import 'package:lab_house/core/data_service.dart';
import 'package:lab_house/modules/ranking/model/ranking.dto.m.dart';

abstract class DeleteRankingUseCase {
  Future<void> execute(int id);
}

class DeleteRankingUseCaseDefault with DataService implements DeleteRankingUseCase {
  // MARK: - Public Methods

  @override
  Future<void> execute(int id) => delete<RankingDTO>(id);
}
