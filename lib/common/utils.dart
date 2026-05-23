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
