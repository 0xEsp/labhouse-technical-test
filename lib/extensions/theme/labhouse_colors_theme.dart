part of 'labhouse_theme.dart';

extension JGColors on Colors {
  // MARK: - White

  static Color get primaryWhite => const Color(0xFFF7F7F7);

  // MARK: - Neutral

  static Color get neutralOriginal => const Color(0xFF2F4858);

  // MARK: - Grey

  static Color get nightAtDisco => const Color(0xFF292929);
  static Color get primaryGrey20 => const Color(0xFFDBE0E3);
  static Color get primaryGrey50 => const Color(0xFF8B959A);
  static Color get primaryGrey60 => const Color(0xFF68757C);
  static Color get primaryGrey70 => const Color(0xFF4C575D);

  // MARK: - Blue

  static Color get primaryTurquoise => const Color(0xFF32C9AC);
  static Color get primaryBlue => const Color(0xFF1DA1F1);
  static Color get backgroundBlue10 => const Color(0xFFE0F3FF);

  // MARK: - Green

  static Color get successGreen => const Color(0xFF41CA80);

  // MARK: - Red

  static Color get actionNegativeRed => const Color(0xFFEB1E47);
  static Color get secondaryFresa => const Color(0xFFF04A3C);

  // MARK: - Yellow

  static Color get otherYellow => const Color(0xFFFFE118);

  // MARK: - Purple

  static Color get primaryPurple => const Color(0xFF0515E1);

  // MARK: - Dark mode surfaces

  /// App background in dark mode.
  static Color get darkBackground => const Color(0xFF121212);

  /// Elevated surfaces (cards, app bar) in dark mode.
  static Color get darkSurface => const Color(0xFF1E1E1E);

  /// Primary text/icon color on dark surfaces.
  static Color get darkOnSurface => const Color(0xFFE6E6E6);

  // MARK: - Theme-aware helpers

  static Color onSurface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkOnSurface
      : nightAtDisco;

  static Color surface(BuildContext context) =>
      Theme.of(context).cardTheme.color ?? primaryWhite;
}
