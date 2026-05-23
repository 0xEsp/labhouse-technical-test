part of 'labhouse_button.dart';

enum LabhouseButtonStyle {
  // Common
  main,
  whiteMain,
  outlined,
  link,
}

extension LabhouseButtonStyleExtension on LabhouseButtonStyle {
  ButtonStyle? get theme {
    switch (this) {
      case LabhouseButtonStyle.main:
        return LabhouseElevatedButtonTheme.main.style;
      case LabhouseButtonStyle.whiteMain:
        return LabhouseElevatedButtonTheme.whiteMain.style;
      case LabhouseButtonStyle.outlined:
        return LabhouseElevatedButtonTheme.outlined.style;
      case LabhouseButtonStyle.link:
        return LabhouseElevatedButtonTheme.link.style;
    }
  }

  TextStyle? get textStyle {
    switch (this) {
      case LabhouseButtonStyle.main:
      case LabhouseButtonStyle.whiteMain:
      case LabhouseButtonStyle.outlined:
        return LabhouseTextTheme.semibold(size: 18);
      case LabhouseButtonStyle.link:
        return LabhouseTextTheme.semibold(
          size: 14,
          color: JGColors.primaryGrey70,
        ).copyWith(decoration: TextDecoration.underline);
    }
  }

  bool get hasShadow {
    switch (this) {
      case LabhouseButtonStyle.link:
        return false;
      case LabhouseButtonStyle.main:
      case LabhouseButtonStyle.whiteMain:
      case LabhouseButtonStyle.outlined:
        return true;
    }
  }
}
