import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/cache/cache_storage.dart';
import 'package:lab_house/core/secure/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension PersistanceAssembly on Assembly {
  void setPersistanceAssembly() {
    // MARK: - Cache

    /// Required to register as async due `DependsOn` relation with other classes
    getIt.registerSingletonAsync<CacheStorage>(
      () async => CacheStorageDefault(),
    );

    // MARK: - Secure

    /// Required to register as async due `DependsOn` relation with other classes
    getIt.registerSingletonAsync<SecureStorage>(
      () async => SecureStorageDefault(),
    );

    // MARK: - Shared

    getIt.registerSingleton<SharedPreferencesAsync>(SharedPreferencesAsync());
  }
}
