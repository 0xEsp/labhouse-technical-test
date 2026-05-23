import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/openai_model.m.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';
import 'package:lab_house/modules/ranking/usecases/generate_ranking_usecase.dart';
import 'package:lab_house/modules/ranking/usecases/get_rankings_usecase.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  // MARK: - Properties

  final _generateRankingUseCase = container.get<GenerateRankingUseCase>();
  final _getRankingsUseCase = container.get<GetRankingsUseCase>();

  // MARK: - Lifecycle

  RankingBloc() : super(const RankingState(isListLoading: true)) {
    on<RankingFetch>(_fetchRankings);
    on<RankingGeneration>(_generateRanking);
  }

  // MARK: - Events Methods

  Future<void> _fetchRankings(
    RankingFetch event,
    Emitter<RankingState> emit,
  ) async {
    emit(state.copyWith(isListLoading: true));

    try {
      final rankings = await _getRankingsUseCase.execute();

      emit(state.copyWith(rankings: rankings, isListLoading: false));
    } catch (_) {
      emit(state.copyWith(isListLoading: false));
    }
  }

  Future<void> _generateRanking(
    RankingGeneration event,
    Emitter<RankingState> emit,
  ) async {
    emit(state.copyWith(isGenerating: true));

    try {
      final ranking = await _generateRankingUseCase.execute(
        query: event.query,
        model: event.model,
      );

      emit(
        state.copyWith(
          rankings: [...state.rankings, ranking],
          isGenerating: false,
        ),
      );
    } catch (_) {
      emit(state.copyWith(isGenerating: false));
    }
  }
}
