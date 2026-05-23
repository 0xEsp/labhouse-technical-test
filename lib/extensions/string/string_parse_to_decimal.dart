import 'package:lab_house/common/utils.dart';

extension StringParseToDecimal on String {
  // todo Fails transformation, try with a Samsung
  double? decimalParse() {
    final decimalSym = Utils.decimalSeparator;
    final value = replaceAll(RegExp('[^0-9$decimalSym]'), '');
    final valueWithDots = value.replaceAll(decimalSym, '.');

    return double.tryParse(valueWithDots);
  }
}
