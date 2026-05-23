/// Base contract for input validators.
///
/// A validator is a pure object that, given a value, returns either `null`
/// (valid) or the localized error message describing why the value is invalid.
///
/// Implementations must be free of Flutter dependencies so they can be unit
/// tested without any binding initialization. Localized error messages are
/// injected by the caller, never resolved inside the validator.
abstract class Validator<T> {
  const Validator();

  /// Returns `null` when [value] is valid, otherwise the error message.
  String? validate(T? value);

  /// Makes the validator directly compatible with `FormField.validator`-style
  /// callbacks: `TextFormField(validator: emailValidator, ...)`.
  String? call(T? value) => validate(value);
}
