import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/common/utils.dart';
import 'package:lab_house/core/api/api_client_adapter.dart';
import 'package:lab_house/core/api/model/api_response_error.m.dart';
import 'package:lab_house/core/managers/secrets_manager.dart';
import 'package:lab_house/modules/environment/shared/environment.dart';

part 'api/model/api_endpoint.m.dart';
part 'api/model/http_method.m.dart';
part 'api/api_service.dart';

mixin DataService implements ApiService {
  final _api = container.get<ApiService>();

  @override
  Future<T> request<T>({
    required String path,
    String base = '/api',
    String version = '/v1',
    HTTPMethod method = HTTPMethod.get,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, String?>? extraHeaders,
    bool retrieveFullResponse = false,
    T Function(Object? json)? resultParser,
  }) async {
    return await _api.request<T>(
      path: path,
      base: base,
      version: version,
      method: method,
      queryParameters: queryParameters,
      body: body,
      extraHeaders: extraHeaders,
      retrieveFullResponse: retrieveFullResponse,
      resultParser: resultParser,
    );
  }

  @override
  void updateEnvironmentUrl(String newUrl) {}
}
