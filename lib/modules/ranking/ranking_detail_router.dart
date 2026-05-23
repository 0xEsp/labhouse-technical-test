import 'package:go_router/go_router.dart';
import 'package:lab_house/common/presentation/transition/screen_transition.dart';
import 'package:lab_house/common/router/router_builder.dart';
import 'package:lab_house/common/router/routes.m.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';
import 'package:lab_house/modules/ranking/screens/ranking_detail_screen.dart';

class RankingDetailRouter implements RouterBuilder {
  // MARK: - Properties

  static final shared = RankingDetailRouter._();

  // MARK: - Lifecycle

  RankingDetailRouter._();

  // MARK: - Public Methods

  @override
  GoRoute flow() {
    return GoRoute(
      path: Routes.rankingDetail.path,
      name: Routes.rankingDetail.name,
      pageBuilder: (context, state) => ScreenTransition.stack.page(
        context,
        state,
        screen: RankingDetailScreen(ranking: state.extra as Ranking),
      ),
    );
  }
}
