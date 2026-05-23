import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lab_house/common/colorize/colorize.dart';
import 'package:lab_house/common/colorize/colorize_styles.m.dart';

/// A simple dio log interceptor (mainly inspired by the built-in dio `LogInterceptor`),
/// which has coloring features and json formatting so you can have a better readable output.
class InterceptorLogs implements Interceptor {
  /// Creates a colorful dio logging interceptor, which has the following:
  /// `requestStyle`: The request color style, defaults to `YELLOW`
  ///
  /// `responseStyle`: The response color style, defaults to `GREEN`
  ///
  /// `errorStyle`: The error response color style, defaults to `RED`
  ///
  /// `logRequestHeaders`: Whether to log the request headrers or not,
  /// it should minimize the logging output.
  ///
  /// **Example**
  ///
  /// ```dart
  /// dio.interceptors.add(InterceptorLogs());
  /// ```
  InterceptorLogs({
    ColorizeStyles? requestStyle,
    ColorizeStyles? responseStyle,
    ColorizeStyles? errorStyle,
  }) : _requestStyle = requestStyle ?? _defaultRequestStyle,
       _responseStyle = responseStyle ?? _defaultResponseStyle,
       _errorStyle = errorStyle ?? _defaultErrorStyle;

  static const ColorizeStyles _defaultRequestStyle = ColorizeStyles.yellow;
  static const ColorizeStyles _defaultResponseStyle = ColorizeStyles.blue;
  static const ColorizeStyles _defaultErrorStyle = ColorizeStyles.red;

  final _jsonEncoder = const JsonEncoder.withIndent('  ');
  final _logRequestHeaders = false;
  final _logResponseHeaders = true;
  final _logRequestTimeout = false;
  final void Function(String log) _logger = log;

  late final ColorizeStyles _requestStyle;
  late final ColorizeStyles _responseStyle;
  late final ColorizeStyles _errorStyle;

  // MARK: - Overrides

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logError(err, style: _errorStyle);
    if (err.response != null) {
      _logResponse(err.response!, error: true, style: _errorStyle);
    }
    _logNewLine();

    _delay();

    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options, style: _requestStyle);
    _logNewLine();

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response, style: _responseStyle);
    _logNewLine();

    handler.next(response);
  }

  // MARK: - Methods

  void _log({
    required String key,
    required String value,
    ColorizeStyles? style,
  }) {
    final coloredMessage = Colorize(
      '$key$value',
    ).apply(style ?? ColorizeStyles.lightGray);

    _logger(coloredMessage.initial);
  }

  void _logJson({
    required String key,
    dynamic value,
    ColorizeStyles? style,
    bool isResponse = false,
  }) {
    final isFormData = value.runtimeType == FormData;
    final isValueNull = value == null;

    final encodedJson = _jsonEncoder.convert(
      isFormData ? Map.fromEntries((value as FormData).fields) : value,
    );
    _log(
      key: isResponse
          ? key
          : '${isFormData
                ? '[formData.fields]'
                : !isValueNull
                ? '[Json]'
                : ''} $key',
      value: encodedJson,
      style: style,
    );

    if (isFormData && !isResponse) {
      final files = (value as FormData).files
          .map((e) => e.value.filename ?? 'Null or Empty filename')
          .toList();

      if (files.isNotEmpty) {
        final encodedJson = _jsonEncoder.convert(files);
        _log(
          key: '[formData.files] Request Body:\n',
          value: encodedJson,
          style: style,
        );
      }
    }
  }

  void _logHeaders({required Map headers, ColorizeStyles? style}) {
    _log(key: 'Headers:', value: '', style: style);

    headers.forEach((key, value) {
      _log(
        key: '\t$key: ',
        value: (value is List && value.length == 1)
            ? value.first
            : value.toString(),
        style: style,
      );
    });
  }

  void _logNewLine() => _log(key: '', value: '');

  void _logRequest(RequestOptions options, {ColorizeStyles? style}) {
    _log(
      key: '🚀🕐 [REQUEST][TIME] ${DateTime.now()} ->',
      value: '',
      style: _requestStyle,
    );
    _log(key: 'Uri: ', value: options.uri.toString(), style: _requestStyle);
    _log(key: 'Method: ', value: options.method, style: _requestStyle);
    _log(
      key: 'Response Type: ',
      value: options.responseType.toString(),
      style: style,
    );
    _log(
      key: 'Follow Redirects: ',
      value: options.followRedirects.toString(),
      style: style,
    );
    if (_logRequestTimeout) {
      _log(
        key: 'Connection Timeout: ',
        value: options.connectTimeout.toString(),
        style: style,
      );
      _log(
        key: 'Send Timeout: ',
        value: options.sendTimeout.toString(),
        style: style,
      );
      _log(
        key: 'Receive Timeout: ',
        value: options.receiveTimeout.toString(),
        style: style,
      );
    }
    _log(
      key: 'Receive Data When Status Error: ',
      value: options.receiveDataWhenStatusError.toString(),
      style: style,
    );
    _log(key: 'Extra: ', value: options.extra.toString(), style: style);
    if (_logRequestHeaders) _logHeaders(headers: options.headers, style: style);
    _logJson(key: 'Request Body:\n', value: options.data, style: style);
  }

  void _logResponse(
    Response response, {
    ColorizeStyles? style,
    bool error = false,
  }) {
    if (!error) {
      _log(
        key: '🌍🕐 [RESPONSE][TIME] ${DateTime.now()} ->',
        value: '',
        style: style,
      );
    }
    _log(key: 'Uri: ', value: response.realUri.toString(), style: style);
    _log(
      key: 'Request Method: ',
      value: response.requestOptions.method,
      style: style,
    );
    _log(key: 'Status Code: ', value: '${response.statusCode}', style: style);
    if (_logResponseHeaders) {
      _logHeaders(headers: response.headers.map, style: style);
    }
    _logJson(
      key: 'Response Body:\n',
      value: response.data,
      style: style,
      isResponse: true,
    );
  }

  void _logError(DioException err, {ColorizeStyles? style}) {
    _log(
      key: '❌🕐 [RESPONSE][TIME] ${DateTime.now()} ->',
      value: '',
      style: style,
    );
    _log(
      key: 'DioException: ',
      value: '[${err.type.toString()}]: ${err.message}',
      style: style,
    );
  }

  void _delay() async =>
      await Future.delayed(const Duration(milliseconds: 200));
}
