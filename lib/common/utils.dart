import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/common/router/router_key.dart';
import 'package:lab_house/core/api/model/api_response_error.m.dart';
import 'package:lab_house/core/cache/cache_storage.dart';
import 'package:lab_house/core/cache/model/cached_decimal_separator.m.dart';

class Utils {
  static ARPError mapDioExceptionToARPError(DioException err) {
    return ARPError(
      type: ARPErrorType.internal,
      reason: 'DIO EXCEPTION: -> ${err.message ?? err.response.toString()}',
      extra: {
        'request-endpoint':
            err.response?.realUri.path ?? err.requestOptions.path,
      },
    );
  }

  // MARK: - OpenAI error mapping

  /// OpenAI `error.type` -> generic [ARPErrorType].
  static const _openAiTypeMap = <String, ARPErrorType>{
    'invalid_request_error': ARPErrorType.invalidRequest,
    'authentication_error': ARPErrorType.authentication,
    'rate_limit_error': ARPErrorType.rateLimit,
    'server_error': ARPErrorType.internal,
  };

  /// OpenAI `error.code` -> specific [ARPErrorCode].
  static const _openAiCodeMap = <String, ARPErrorCode>{
    'invalid_api_key': ARPErrorCode.invalidApiKey,
    'insufficient_quota': ARPErrorCode.insufficientQuota,
    'rate_limit_exceeded': ARPErrorCode.rateLimitExceeded,
    'model_not_found': ARPErrorCode.modelNotFound,
    'context_length_exceeded': ARPErrorCode.contextLengthExceeded,
    'content_policy_violation': ARPErrorCode.contentPolicyViolation,
    'server_error': ARPErrorCode.serverError,
    'unsupported_country_region_territory': ARPErrorCode.unsupportedRegion,
  };

  static ARPError mapOpenAIErrorToARPError(
    int? status,
    Map<String, dynamic> error,
  ) {
    final rawCode = error['code'];
    final rawType = error['type'] as String?;
    final message = error['message'] as String? ?? 'Unknown OpenAI error';

    final code = rawCode is String ? _openAiCodeMap[rawCode] : null;
    final type =
        _openAiTypeMap[rawType] ??
        _typeFromStatus(status) ??
        ARPErrorType.internal;

    return ARPError(
      type: type,
      reason: message,
      code: code,
      extra: {
        'openai-type': ?rawType,
        if (rawCode != null) 'openai-code': rawCode.toString(),
        if (status != null) 'http-status': status.toString(),
      },
    );
  }

  static ARPErrorType? _typeFromStatus(int? status) => switch (status) {
    401 || 403 => ARPErrorType.authentication,
    429 => ARPErrorType.rateLimit,
    400 || 404 || 422 => ARPErrorType.invalidRequest,
    _ => null,
  };

  static String get languageCode {
    final locale = routerKey.currentContext != null
        ? Localizations.localeOf(routerKey.currentContext!)
        : null;
    return locale?.languageCode ?? Intl.getCurrentLocale();
  }

  static String get decimalSeparator {
    final cache = container.get<CacheStorage>();
    final model = cache.retrieve<CachedDecimalSeparator>();
    if (model != null) return model.decimalSep;
    final languageCode = Utils.languageCode;
    final numberFormat = NumberFormat.decimalPattern(languageCode);
    return numberFormat.symbols.DECIMAL_SEP;
  }
}
