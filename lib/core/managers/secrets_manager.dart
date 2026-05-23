import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/secure/secure_storage.dart';

enum Secret {
  openaiApiKey;

  static const openaiApiKeyValue = 'OPENAI_API_KEY';

  SecureOption get secureOption => switch (this) {
    Secret.openaiApiKey => SecureOption.openaiApiKey,
  };

  String get environmentValue => switch (this) {
    Secret.openaiApiKey => const String.fromEnvironment(openaiApiKeyValue),
  };
}

class SecretsManager {
  // MARK: - Properties

  final _secureStorage = container.get<SecureStorage>();

  final Map<Secret, String?> _storedValues;

  // MARK: - Lifecycle

  SecretsManager._(this._storedValues);

  static Future<SecretsManager> init() async {
    final secureStorage = container.get<SecureStorage>();
    final stored = <Secret, String?>{};

    for (final secret in Secret.values) {
      stored[secret] = await secureStorage.read(option: secret.secureOption);
    }

    return SecretsManager._(stored);
  }

  // MARK: - Public Methods

  String get(Secret secret) {
    final stored = _storedValues[secret];

    final hasStoredValue = stored != null && stored.isNotEmpty;

    return hasStoredValue ? stored : secret.environmentValue;
  }

  /// Persists a user-provided [secret] value into [SecureStorage] and refreshes
  /// the in-memory cache so subsequent [get] calls return it immediately.
  Future<void> update(Secret secret, String value) async {
    await _secureStorage.write(option: secret.secureOption, value: value);

    _storedValues[secret] = value;
  }
}
