part of 'secure_storage.dart';

class SecureStorageDefault implements SecureStorage {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  @override
  Future<void> write({
    required SecureOption option,
    required String? value,
  }) async {
    return await _storage.write(key: option.key, value: value);
  }

  @override
  Future<String?> read({required SecureOption option}) async {
    return await _storage.read(key: option.key);
  }

  @override
  Future<void> delete({required SecureOption option}) async {
    return await _storage.delete(key: option.key);
  }

  @override
  Future<void> deleteAll() async {
    return await _storage.deleteAll();
  }
}
