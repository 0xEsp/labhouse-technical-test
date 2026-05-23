import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/border/labhouse_outline_input_border.dart';

part 'labhouse_appbar_theme.dart';
part 'labhouse_colors_theme.dart';
part 'labhouse_elevated_button_theme.dart';
part 'labhouse_text_theme.dart';
part 'labhouse_input_theme.dart';
part 'labhouse_bottom_sheet_theme.dart';
part 'labhouse_card_theme.dart';

extension LabhouseTheme on ThemeData {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    // Remove transparent color for custom one at moment for ink widget ripple effect
    highlightColor: JGColors.neutralOriginal.withValues(alpha: .3),
    focusColor: Colors.transparent,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: JGColors.primaryTurquoise,
      secondary: Colors.transparent,
    ),
    scaffoldBackgroundColor: JGColors.primaryWhite,
    inputDecorationTheme: LabhouseInputTheme.base,
    appBarTheme: LabhouseAppBarTheme.light,
    bottomSheetTheme: LabhouseBottomSheetTheme.main,
    cardTheme: LabhouseCardTheme.base.data,
  );

  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    splashColor: Colors.transparent,
    highlightColor: JGColors.darkOnSurface.withValues(alpha: .3),
    focusColor: Colors.transparent,
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
    ).copyWith(primary: JGColors.primaryTurquoise, secondary: Colors.transparent),
    scaffoldBackgroundColor: JGColors.darkBackground,
    inputDecorationTheme: LabhouseInputTheme.dark,
    appBarTheme: LabhouseAppBarTheme.dark,
    bottomSheetTheme: LabhouseBottomSheetTheme.main,
    cardTheme: LabhouseCardTheme.dark.data,
  );
}
