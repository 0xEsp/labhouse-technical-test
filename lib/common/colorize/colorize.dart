import 'package:lab_house/common/colorize/colorize_styles.m.dart';

class Colorize {
  final String _esc = "\u{1B}";

  String initial = '';

  Colorize([this.initial = '']);

  Colorize apply(ColorizeStyles style, [String? text]) {
    text ??= initial;

    initial = _applyStyle(style, text);

    return this;
  }

  String buildEscSeq(ColorizeStyles style) {
    return "$_esc[${style.value}m";
  }

  Colorize call(String text) {
    initial = text;

    return this;
  }

  String _applyStyle(ColorizeStyles style, String text) {
    return buildEscSeq(style) + text + buildEscSeq(ColorizeStyles.reset);
  }
}
