part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  // MARK: - Properties

  final AppThemeMode themeMode;
  final AppLanguage language;
  final String apiKey;

  // MARK: - Lifecycle

  const SettingsState({
    required this.themeMode,
    required this.language,
    required this.apiKey,
  });

  // MARK: - Computed

  /// Obfuscated API key for display: only the last 3 characters are revealed.
  /// Returns an empty string when no key is configured.
  String get maskedApiKey {
    if (apiKey.length <= 3) return apiKey;

    return '${'*' * (apiKey.length - 3)}${apiKey.lastChars(3)}';
  }

  bool get hasApiKey => apiKey.isNotEmpty;

  // MARK: - Copy

  SettingsState copyWith({
    AppThemeMode? themeMode,
    AppLanguage? language,
    String? apiKey,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      apiKey: apiKey ?? this.apiKey,
    );
  }

  @override
  List<Object> get props => [themeMode, language, apiKey];
}
