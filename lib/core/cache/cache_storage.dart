import 'dart:collection';

part 'cache_storage_default.dart';

abstract class CacheStorage {
  void save<T>(T value);

  T? retrieve<T>();

  void remove<T>(T type);

  void removeAll();
}
