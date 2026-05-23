part of 'labhouse_theme.dart';

extension LabhouseCardTheme on CardTheme {
  static BorderRadius get defaultRadius => BorderRadius.circular(20);
  static BorderRadius get lowRadius => BorderRadius.circular(16);

  static CardTheme get base => CardTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: .5,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: defaultRadius),
  );
}
