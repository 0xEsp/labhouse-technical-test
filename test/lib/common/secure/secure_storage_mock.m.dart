import 'package:lab_house/core/secure/secure_storage.dart';

class MockSecureStorage implements SecureStorage {
  Map<SecureOption, String?> mockValues = {};
  Exception? error;

  @override
  Future<void> write({
    required SecureOption option,
    required String? value,
  }) async => mockValues[option] = value;

  @override
  Future<String?> read({required SecureOption option}) async =>
      (error != null) ? throw error! : mockValues[option];

  @override
  Future<void> delete({required SecureOption option}) async {
    if (error != null) throw error!;

    mockValues.remove(option);
  }

  @override
  Future<void> deleteAll() async {
    if (error != null) throw error!;

    mockValues.clear();
  }
}
