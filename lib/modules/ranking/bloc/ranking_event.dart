part of 'ranking_bloc.dart';

sealed class RankingEvent extends Equatable {
  const RankingEvent();

  @override
  List<Object> get props => [];
}

final class RankingGeneration extends RankingEvent {
  final RankingGenerationInput input;

  const RankingGeneration(this.input);

  @override
  List<Object> get props => [input];
}

final class RankingFetch extends RankingEvent {}

final class RankingDeletion extends RankingEvent {
  final int id;

  const RankingDeletion(this.id);

  @override
  List<Object> get props => [id];
}
