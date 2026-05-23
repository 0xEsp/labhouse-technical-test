class Lazy<T> {
  late T _value;
  final T Function() initializer;

  Lazy(this.initializer) : _value = initializer();

  T get value {
    _value ??= initializer();
    return _value;
  }

  set value(T newValue) => _value = newValue;
}
