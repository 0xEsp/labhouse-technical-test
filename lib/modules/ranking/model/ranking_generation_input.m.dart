import 'package:equatable/equatable.dart';
import 'package:lab_house/core/api/model/openai_model.m.dart';

/// Parameters the user provides to generate a new ranking.
class RankingGenerationInput extends Equatable {
  final String query;
  final OpenAIModel model;
  final bool webSearch;

  const RankingGenerationInput({
    required this.query,
    required this.model,
    required this.webSearch,
  });

  @override
  List<Object> get props => [query, model, webSearch];
}
