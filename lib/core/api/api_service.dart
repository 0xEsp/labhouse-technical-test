part of '../data_service.dart';

abstract class ApiService {
  Future<T> request<T>({
    required String path,
    required String base,
    required String version,
    required HTTPMethod method,
    required Map<String, dynamic>? queryParameters,
    required Object? body,
    required Map<String, String?>? extraHeaders,
    required bool retrieveFullResponse,
    required T Function(Object? json)? resultParser,
  });
  void updateEnvironmentUrl(String newUrl);
}

final class ApiServiceDefault implements ApiService {
  final _envUrl = container.get<Environment>().baseUrl;

  late final Map<String, String?> _headers = {
    'accept': "application/json",
    'Content-type': 'application/json;charset=UTF-8',
  };

  late final Dio _dio = container.get<Dio>()
    ..options = BaseOptions(
      baseUrl: _envUrl,
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: kDebugMode ? 1800 : 5),
      preserveHeaderCase: true,
    )
    ..httpClientAdapter = ApiClientAdapter.create();

  @override
  Future<T> request<T>({
    required String path,
    required String base,
    required String version,
    required HTTPMethod method,
    required Map<String, dynamic>? queryParameters,
    required Object? body,
    required Map<String, String?>? extraHeaders,
    required bool retrieveFullResponse,
    required T Function(Object? json)? resultParser,
  }) async {
    assert(
      T != Null || resultParser == null,
      'If generic type is null, resultParser cannot be provided',
    );

    final url = '$base$version$path';

    try {
      final headers = await _loadRequestHeaders(extraHeaders);

      final response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: body,
        options: Options(method: method.name.toUpperCase(), headers: headers),
      );

      final data = response.data;
      if (retrieveFullResponse || resultParser == null) return data as T;

      return resultParser(data);
    } on ARPError {
      rethrow;
    } on DioException catch (dioError) {
      final data = dioError.response?.data;

      if (data is Map<String, dynamic> &&
          data['error'] is Map<String, dynamic>) {
        throw Utils.mapOpenAIErrorToARPError(
          dioError.response?.statusCode,
          data['error'] as Map<String, dynamic>,
        );
      }

      final error = dioError.error;
      if (error is! ARPError) throw Utils.mapDioExceptionToARPError(dioError);
      throw error;
    } catch (error) {
      throw ARPError(type: ARPErrorType.internal, reason: error.toString());
    }
  }

  @override
  void updateEnvironmentUrl(String newUrl) {
    _dio.options.baseUrl = newUrl;
  }

  // MARK: - Private Methods

  Future<Map<String, String?>> _loadRequestHeaders(
    Map<String, String?>? extraHeaders,
  ) async {
    _headers['Authorization'] = _retrieveAuthToken();

    final headers = Map<String, String?>.of(_headers);
    extraHeaders?.forEach((key, value) => headers[key] = value);
    return headers;
  }

  /// Bearer token for OpenAI, resolved from [SecretsManager] (secure storage
  /// override, falling back to the compile-time `OPENAI_API_KEY`).
  String _retrieveAuthToken() {
    final apiKey = container.get<SecretsManager>().get(Secret.openaiApiKey);

    return 'Bearer $apiKey';
  }
}
