part of 'ranking_bloc.dart';

class RankingState extends Equatable {
  final List<Ranking> rankings;
  final bool isListLoading;
  final bool isGenerating;

  const RankingState({
    this.rankings = const [],
    this.isListLoading = false,
    this.isGenerating = false,
  });

  RankingState copyWith({
    List<Ranking>? rankings,
    bool? isListLoading,
    bool? isGenerating,
  }) {
    return RankingState(
      rankings: rankings ?? this.rankings,
      isListLoading: isListLoading ?? this.isListLoading,
      isGenerating: isGenerating ?? this.isGenerating,
    );
  }

  @override
  List<Object> get props => [rankings, isListLoading, isGenerating];
}
