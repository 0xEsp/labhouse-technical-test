part of 'ranking_bloc.dart';

class RankingState extends Equatable {
  final List<Ranking> rankings;
  final bool isListLoading;
  final bool isGenerating;
  final ARPError? error;

  const RankingState({
    this.rankings = const [],
    this.isListLoading = false,
    this.isGenerating = false,
    this.error,
  });

  RankingState copyWith({
    List<Ranking>? rankings,
    bool? isListLoading,
    bool? isGenerating,
    ARPError? error,
    bool clearError = false,
  }) {
    return RankingState(
      rankings: rankings ?? this.rankings,
      isListLoading: isListLoading ?? this.isListLoading,
      isGenerating: isGenerating ?? this.isGenerating,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [rankings, isListLoading, isGenerating, error];
}
