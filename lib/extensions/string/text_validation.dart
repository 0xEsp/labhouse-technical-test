extension TextValidator on String {
  /// Validates if the string is a valid email address.
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(this);
  }

  /// Validates if the string is a valid URL.
  bool isValidUrl() {
    final urlRegex = RegExp(r'^(https?|ftp)://[^\s/$.?#].[^\s]*$');

    return urlRegex.hasMatch(this);
  }

  /// Validates if the string is a valid phone number.
  bool isValidPhoneNumber() {
    final phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

    return phoneRegex.hasMatch(this);
  }
}
