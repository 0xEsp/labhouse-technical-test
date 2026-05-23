part of 'secure_storage.dart';

enum SecureOption {
  session('user-session-storage');

  final String key;

  const SecureOption(this.key);
}
