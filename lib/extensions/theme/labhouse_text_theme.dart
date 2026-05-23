part of 'labhouse_theme.dart';

extension LabhouseTextTheme on TextTheme {
  // MARK: - Specific Text Theme

  static TextStyle semibold({
    Color? color,
    double size = 14,
    double height = 1.35,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'InterTight',
      color: color,
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w600,
      decoration: decoration,
      decorationColor: color,
    );
  }

  static TextStyle medium({
    Color? color,
    double size = 14,
    double height = 1.35,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'InterTight',
      color: color,
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w500,
      decoration: decoration,
      decorationColor: color,
    );
  }

  static TextStyle regular({
    Color? color,
    double size = 14,
    double height = 1.35,
    TextDecoration? decoration,
  }) {
    return TextStyle(
      fontFamily: 'InterTight',
      color: color,
      fontSize: size,
      height: height,
      fontWeight: FontWeight.w400,
      decoration: decoration,
      decorationColor: color,
    );
  }
}
