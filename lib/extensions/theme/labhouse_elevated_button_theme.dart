part of 'labhouse_theme.dart';

extension LabhouseElevatedButtonTheme on ElevatedButtonThemeData {
  static BorderRadius get defaultRadius => BorderRadius.circular(20);

  static ElevatedButtonThemeData get main => ElevatedButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return Colors.white;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return JGColors.primaryPurple.withValues(alpha: .3);
        }

        return JGColors.primaryPurple;
      }),
      padding: WidgetStateProperty.all(const EdgeInsets.all(16)),
      minimumSize: WidgetStateProperty.all(const Size(double.minPositive, 55)),
      shape: WidgetStateProperty.resolveWith(
        (_) => RoundedRectangleBorder(borderRadius: defaultRadius),
      ),
      elevation: WidgetStateProperty.all(0),
      enableFeedback: true,
      alignment: Alignment.center,
    ),
  );

  static ElevatedButtonThemeData get whiteMain => ElevatedButtonThemeData(
    style: main.style?.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return JGColors.primaryPurple;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white.withValues(alpha: .5);
        }

        return Colors.white;
      }),
    ),
  );

  static ElevatedButtonThemeData get outlined => ElevatedButtonThemeData(
    style: main.style?.copyWith(
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return JGColors.nightAtDisco;
      }),
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.white.withValues(alpha: .5);
        }

        return Colors.white;
      }),
      shape: WidgetStateProperty.resolveWith(
        (_) => RoundedRectangleBorder(
          borderRadius: defaultRadius,
          side: BorderSide(color: JGColors.primaryGrey20, width: 1),
        ),
      ),
    ),
  );

  static ElevatedButtonThemeData get link => ElevatedButtonThemeData(
    style: ButtonStyle(
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(JGColors.primaryGrey70),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      ),
      minimumSize: WidgetStateProperty.all(const Size(double.minPositive, 32)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: WidgetStateProperty.resolveWith(
        (_) => const RoundedRectangleBorder(),
      ),
      elevation: WidgetStateProperty.all(0),
      enableFeedback: true,
      alignment: Alignment.center,
    ),
  );
}
