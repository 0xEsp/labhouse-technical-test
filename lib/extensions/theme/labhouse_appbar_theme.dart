part of 'labhouse_theme.dart';

extension LabhouseAppBarTheme on AppBarTheme {
  static AppBarTheme get light => AppBarTheme(
    surfaceTintColor: Colors.transparent,
    backgroundColor: JGColors.primaryWhite,
    shadowColor: JGColors.nightAtDisco.withAlpha(70),
    elevation: 0,
    scrolledUnderElevation: 2,
    centerTitle: true,
    titleSpacing: 0,
    titleTextStyle: LabhouseTextTheme.semibold(
      size: 18,
      color: JGColors.nightAtDisco,
    ),
    iconTheme: IconThemeData(color: JGColors.primaryTurquoise, size: 24),
    actionsPadding: EdgeInsets.symmetric(horizontal: 16),
  );
}
