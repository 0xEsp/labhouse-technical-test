import 'package:flutter/material.dart';
import 'package:lab_house/modules/config/model/app_language.m.dart';
import 'package:lab_house/modules/config/model/app_theme_mode.m.dart';

/// Being a [ChangeNotifier] lets `MaterialApp` rebuild via a `ListenableBuilder`
/// without coupling the theme/locale source to any specific Bloc.
class AppSettingsManager extends ChangeNotifier {
  // MARK: - Properties

  AppThemeMode _themeMode = AppThemeMode.systemDefault;
  AppLanguage _language = AppLanguage.systemDefault;

  AppThemeMode get themeMode => _themeMode;
  AppLanguage get language => _language;

  ThemeMode get materialThemeMode => _themeMode.themeMode;
  Locale get locale => _language.locale;

  // MARK: - Public Methods

  void updateThemeMode(AppThemeMode mode) {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();
  }

  void updateLanguage(AppLanguage language) {
    if (_language == language) return;

    _language = language;
    notifyListeners();
  }
}
