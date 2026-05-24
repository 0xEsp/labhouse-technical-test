enum OpenAIModel {
  gpt4oMini('gpt-4o-mini', 'GPT-4o mini'),
  gpt4o('gpt-4o', 'GPT-4o'),
  gpt41Mini('gpt-4.1-mini', 'GPT-4.1 mini'),
  gpt51Mini('gpt-5.4-mini', 'GPT-5.4 mini');

  final String id;
  final String label;

  const OpenAIModel(this.id, this.label);

  static OpenAIModel get defaultModel => OpenAIModel.gpt51Mini;
}
