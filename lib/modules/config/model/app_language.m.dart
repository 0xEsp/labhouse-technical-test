import 'dart:ui';

enum AppLanguage {
  english('en'),
  spanish('es');

  final String code;

  const AppLanguage(this.code);

  /// Flutter representation used by `MaterialApp.locale`.
  Locale get locale => Locale(code);

  /// Restores the persisted value.
  static AppLanguage fromCode(String? code) {
    return AppLanguage.values.firstWhere(
      (language) => language.code == code,
      orElse: () => AppLanguage.systemDefault,
    );
  }

  static AppLanguage fromLocale(Locale? locale) =>
      fromCode(locale?.languageCode);

  /// Language taken from the device
  static AppLanguage get systemDefault {
    final systemCode = PlatformDispatcher.instance.locale.languageCode;

    return AppLanguage.values.firstWhere(
      (language) => language.code == systemCode,
      orElse: () => AppLanguage.english,
    );
  }
}
