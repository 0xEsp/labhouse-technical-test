import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'secure_option.m.dart';
part 'secure_storage_default.dart';

abstract class SecureStorage {
  Future<void> write({required SecureOption option, required String? value});

  Future<String?> read({required SecureOption option});

  Future<void> delete({required SecureOption option});

  Future<void> deleteAll();
}
