import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/managers/secrets_manager.dart';

abstract class SaveApiKeyUseCase {
  Future<void> execute(String apiKey);
}

class SaveApiKeyUseCaseDefault implements SaveApiKeyUseCase {
  // MARK: - Properties

  final _secrets = container.get<SecretsManager>();

  // MARK: - Public Methods

  @override
  Future<void> execute(String apiKey) async {
    // [SecretsManager.update] both persists to SecureStorage and refreshes the
    // in-memory value, so the new key is used immediately without a restart.
    await _secrets.update(Secret.openaiApiKey, apiKey);
  }
}
