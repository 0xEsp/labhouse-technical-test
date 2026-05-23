// ignore_for_file: avoid_relative_lib_imports

import 'package:lab_house/core/cache/cache_storage.dart';
import 'package:lab_house/core/secure/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../lib/common/secure/secure_storage_mock.m.dart';
import 'assembly_mock.dart';

extension PersistanceAssemblyMock on AssemblyMock {
  void setPersistanceAssemblyMock() {
    // MARK: - Memory

    getIt.registerLazySingleton<CacheStorage>(() => CacheStorageDefault());

    // MARK: - Secure

    getIt.registerSingleton<SecureStorage>(MockSecureStorage());

    // MARK: - Shared

    getIt.registerSingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance(),
    );
  }
}
