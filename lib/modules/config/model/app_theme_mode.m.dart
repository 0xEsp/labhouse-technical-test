import 'dart:ui';

import 'package:flutter/material.dart';

enum AppThemeMode {
  light,
  dark;

  /// Flutter representation used by `MaterialApp.themeMode`.
  ThemeMode get themeMode => switch (this) {
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };

  /// Restores the persisted value.
  static AppThemeMode fromName(String? name) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => AppThemeMode.systemDefault,
    );
  }

  static AppThemeMode fromThemeMode(ThemeMode mode) {
    return mode == ThemeMode.dark ? AppThemeMode.dark : AppThemeMode.light;
  }

  static AppThemeMode get systemDefault =>
      PlatformDispatcher.instance.platformBrightness == Brightness.dark
      ? AppThemeMode.dark
      : AppThemeMode.light;
}
