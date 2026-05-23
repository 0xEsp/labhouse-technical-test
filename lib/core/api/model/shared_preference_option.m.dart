enum SharedPreferenceOption {
  env('environment_rawname'),
  theme('app_theme_mode'),
  language('app_language_code');

  final String name;

  const SharedPreferenceOption(this.name);
}
