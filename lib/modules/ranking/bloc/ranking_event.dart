part of 'ranking_bloc.dart';

sealed class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object> get props => [];
}

final class RankingGeneration extends RankingEvent {
  final String query;
  final OpenAIModel model;

  const RankingGeneration({required this.query, required this.model});

  @override
  List<Object> get props => [query, model];
}
