import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/openai_model.m.dart';
import 'package:lab_house/modules/ranking/usecases/generate_ranking_usecase.dart';
import 'package:lab_house/modules/ranking/usecases/get_rankings_usecase.dart';

part 'ranking_event.dart';
part 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  // MARK: - Properties

  final _generateRankingUseCase = container.get<GenerateRankingUseCase>();
  final _getRankingsUseCase = container.get<GetRankingsUseCase>();

  // MARK: - Lifecycle

  RankingBloc() : super(RankingInitial()) {
    on<RankingGeneration>(_generateRanking);
    on<RankingFetch>(_fetchRankings);
  }

  // MARK: - Events Methods

  void _generateRanking(
    RankingGeneration event,
    Emitter<RankingState> emit,
  ) async {
    try {
      final ranking = await _generateRankingUseCase.execute(
        query: event.query,
        model: event.model,
      );

      debugPrint('TODO FUE BIEN; $ranking');
    } catch (error) {
      debugPrint('ALGO MALO PASO; $error');
    }
  }

  void _fetchRankings(RankingFetch event, Emitter<RankingState> emit) async {
    try {
      final rankings = await _getRankingsUseCase.execute();

      debugPrint('RANKINGS EN DB (${rankings.length}); $rankings');
    } catch (error) {
      debugPrint('ALGO MALO PASO; $error');
    }
  }
}
