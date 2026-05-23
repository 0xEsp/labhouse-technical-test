part of 'cache_storage.dart';

/// This class only works with custom model type.
/// Not working with default standard system types like String, Double, etc...
class CacheStorageDefault extends CacheStorage {
  late Map<String, dynamic> storage = HashMap();

  @override
  void save<T>(T value) {
    final key = value.runtimeType.toString();
    storage[key] = value;
  }

  @override
  T? retrieve<T>() {
    return storage[T.toString()] is T ? storage[T.toString()] as T : null;
  }

  @override
  void remove<T>(T type) {
    final typeKey = type.toString();
    storage.removeWhere((key, value) => key == typeKey);
  }

  @override
  void removeAll() => storage.clear();
}
