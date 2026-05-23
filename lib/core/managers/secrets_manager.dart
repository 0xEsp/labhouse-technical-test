enum Secret {
  openaiApiKey;

  static const openaiApiKeyValue = 'OPENAI_API_KEY';
}

class SecretsManager {
  // we could change dynamic secret value based on env, but this project only aims to one env
  //late final Lazy _env = Lazy(() => container.get<Environment>());

  String get(Secret secret) {
    return switch (secret) {
      Secret.openaiApiKey => const String.fromEnvironment(
        Secret.openaiApiKeyValue,
      ),
    };
  }
}
