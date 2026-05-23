import 'package:flutter/material.dart';
import 'package:lab_house/common/router/router_key.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';

mixin LocaleManager {
  AppLocalizations locale(BuildContext? context) {
    final unwrappedContext = context ?? routerKey.currentContext;

    if (unwrappedContext == null) {
      throw Exception('Cannot get current context for localizable text');
    }

    return AppLocalizations.of(unwrappedContext)!;
  }
}
