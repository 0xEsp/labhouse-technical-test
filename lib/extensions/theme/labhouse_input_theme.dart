part of 'labhouse_theme.dart';

extension LabhouseInputTheme on InputDecorationTheme {
  // MARK: - Base Inputs Theme

  static InputDecorationTheme get base => InputDecorationTheme(
    border: WidgetStateInputBorder.resolveWith((states) {
      Color borderColor = Colors.transparent;

      if (states.contains(WidgetState.focused)) {
        borderColor = JGColors.primaryTurquoise;
      } else if (states.contains(WidgetState.error)) {
        borderColor = JGColors.actionNegativeRed;
      }

      return LabhouseOutlineInputBorder(
        borderSide: BorderSide(color: borderColor),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      );
    }),
    labelStyle: LabhouseTextTheme.regular(
      size: 16,
      color: JGColors.primaryGrey50,
    ),
    filled: true,
    helperMaxLines: 1,
    prefixIconConstraints: BoxConstraints(minWidth: 17, minHeight: 17),
    suffixIconConstraints: BoxConstraints(minWidth: 17, minHeight: 17),
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    fillColor: JGColors.primaryGrey20.withValues(alpha: .35),
  );
}
