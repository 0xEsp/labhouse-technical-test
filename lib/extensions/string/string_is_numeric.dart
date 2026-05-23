extension StringNumeric on String {
  bool isNumeric() {
    // Remove all values with comma or dot
    final value = replaceAll(RegExp(r'[^\d]'), '');
    return double.tryParse(value) != null;
  }
}
