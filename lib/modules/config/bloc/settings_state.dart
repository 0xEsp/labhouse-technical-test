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

  /// Obfuscated API key for display. We first trim to the last 10 characters
  /// so the rendered text never grows too large (the leading part is
  /// irrelevant once masked), then reveal only the last 3 — the rest are `*`.
  String get maskedApiKey {
    if (apiKey.isEmpty) return apiKey;

    final trimmed = apiKey.length <= 10 ? apiKey : apiKey.lastChars(10);

    if (trimmed.length <= 3) return trimmed;

    return '${'*' * (trimmed.length - 3)}${trimmed.lastChars(3)}';
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
