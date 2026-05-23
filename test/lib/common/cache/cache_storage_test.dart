import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab_house/core/cache/cache_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../assembly/assembly_mock.dart';
import 'cache_storage_mock.m.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  setUpAll(() => testContainer.setup());
  tearDownAll(() => testContainer.clear());

  group('CacheStorage', () {
    late CacheStorage cacheStorage;

    setUp(() => cacheStorage = testContainer.get<CacheStorage>());

    test(
      'return null if trying to get a value that is not saved or its a system type value',
      () {
        cacheStorage.removeAll();

        expect(cacheStorage.retrieve<String>(), isNull);
        expect(cacheStorage.retrieve<CacheStorageModelMock>(), isNull);
      },
    );

    test('save correct data model in cache', () {
      final model = CacheStorageModelMock('abc123...');
      cacheStorage.save(model);

      expect(cacheStorage.retrieve<CacheStorageModelMock>(), model);
    });

    test('if trying to save same model twice, last one overlay the other', () {
      final model = CacheStorageModelMock('abc123...');
      final model2 = CacheStorageModelMock('...123abc');
      cacheStorage.save(model);
      cacheStorage.save(model2);

      expect(cacheStorage.retrieve<CacheStorageModelMock>(), model2);
    });

    test('remove correct data model in cache', () {
      final model = CacheStorageModelMock('abc123...');
      cacheStorage.save(model);

      expect(cacheStorage.retrieve<CacheStorageModelMock>(), model);
      cacheStorage.remove(model);
      expect(cacheStorage.retrieve<CacheStorageModelMock>(), isNull);
    });

    test('remove correct all storage saved in cache', () {
      final model = CacheStorageModelMock('abc123...');
      final model2 = CacheStorageSecondModelMock(10);
      cacheStorage.save(model);
      cacheStorage.save(model2);

      cacheStorage.removeAll();
      expect(cacheStorage.retrieve<CacheStorageModelMock>(), isNull);
      expect(cacheStorage.retrieve<CacheStorageSecondModelMock>(), isNull);
    });
  });
}
