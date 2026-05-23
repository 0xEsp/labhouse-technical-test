import 'package:lab_house/core/data_service.dart';
import 'package:lab_house/modules/ranking/model/ranking.dto.m.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';

abstract class GetRankingsUseCase {
  Future<List<Ranking>> execute();
}

class GetRankingsUseCaseDefault with DataService implements GetRankingsUseCase {
  // MARK: - Public Methods

  @override
  Future<List<Ranking>> execute() async {
    final dtos = await getAll<RankingDTO>();

    return dtos.map(Ranking.fromDTO).toList();
  }
}
