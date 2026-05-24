import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/api_response_error.m.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';
import 'package:lab_house/modules/ranking/model/ranking_generation_input.m.dart';
import 'package:lab_house/modules/ranking/usecases/delete_ranking_usecase.dart';
import 'package:lab_house/modules/ranking/usecases/generate_ranking_usecase.dart';
import 'package:lab_house/modules/ranking/usecases/get_rankings_usecase.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  // MARK: - Properties

  final _generateRankingUseCase = container.get<GenerateRankingUseCase>();
  final _getRankingsUseCase = container.get<GetRankingsUseCase>();
  final _deleteRankingUseCase = container.get<DeleteRankingUseCase>();

  // MARK: - Lifecycle

  RankingBloc() : super(const RankingState(isListLoading: true)) {
    on<RankingFetch>(_fetchRankings);
    on<RankingGeneration>(_generateRanking);
    on<RankingDeletion>(_deleteRanking);
  }

  // MARK: - Events Methods

  Future<void> _fetchRankings(
    RankingFetch event,
    Emitter<RankingState> emit,
  ) async {
    emit(state.copyWith(isListLoading: true, clearError: true));

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
    emit(state.copyWith(isGenerating: true, clearError: true));

    try {
      final ranking = await _generateRankingUseCase.execute(event.input);

      emit(
        state.copyWith(
          rankings: [...state.rankings, ranking],
          isGenerating: false,
        ),
      );
    } catch (error) {
      emit(state.copyWith(isGenerating: false, error: _asArpError(error)));
    }
  }

  Future<void> _deleteRanking(
    RankingDeletion event,
    Emitter<RankingState> emit,
  ) async {
    try {
      await _deleteRankingUseCase.execute(event.id);

      emit(
        state.copyWith(
          rankings: state.rankings
              .where((ranking) => ranking.id != event.id)
              .toList(),
          clearError: true,
        ),
      );
    } catch (_) {}
  }

  // MARK: - Private Methods

  ARPError _asArpError(Object error) => error is ARPError
      ? error
      : ARPError(type: ARPErrorType.internal, reason: error.toString());
}
