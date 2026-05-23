part of 'secure_storage.dart';

enum SecureOption {
  session('user-session-storage'),
  openaiApiKey('openai-api-key-storage');

  final String key;

  const SecureOption(this.key);
}
