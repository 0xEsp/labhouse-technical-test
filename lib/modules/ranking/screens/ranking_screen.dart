import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/common/presentation/appbar/labhouse_app_bar.dart';
import 'package:lab_house/common/router/routes.m.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/core/managers/navigation_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/ranking/bloc/ranking_bloc.dart';
import 'package:lab_house/modules/ranking/components/ranking_card.dart';
import 'package:lab_house/modules/ranking/components/search_ranking_toast.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';

class RankingScreen extends StatelessWidget
    with LocaleManager, NavigationManager {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return Scaffold(
      appBar: LabhouseAppBar(
        title: lc.ranking_tap_copy,
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, color: JGColors.primaryTurquoise),
            onPressed: () => _openSearch(context),
          ),
        ],
      ),
      body: BlocBuilder<RankingBloc, RankingState>(
        builder: (context, state) {
          return RefreshIndicator(
            color: JGColors.primaryTurquoise,
            onRefresh: () => _refresh(context),
            child: _body(context, state),
          );
        },
      ),
    );
  }

  // MARK: - Body

  Widget _body(BuildContext context, RankingState state) {
    if (state.isListLoading && state.rankings.isEmpty) {
      return const RankingShimmerList();
    }

    if (state.rankings.isEmpty) return _emptyState(context);

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: state.rankings.length,
      separatorBuilder: (_, _) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        final ranking = state.rankings[index];

        return RankingCard(
          ranking: ranking,
          onTap: () => _openDetail(context, ranking),
        );
      },
    );
  }

  Widget _emptyState(BuildContext context) {
    final lc = locale(context);

    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                lc.rankings_empty,
                textAlign: TextAlign.center,
                style: LabhouseTextTheme.medium(
                  size: 16,
                  color: JGColors.primaryGrey50,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MARK: - Actions

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<RankingBloc>();

    bloc.add(RankingFetch());

    await bloc.stream.firstWhere((state) => !state.isListLoading);
  }

  void _openSearch(BuildContext context) {
    final bloc = context.read<RankingBloc>();
    final countBefore = bloc.state.rankings.length;

    toast(
      context,
      handleKeyboard: true,
      enableDrag: false,
      onDismiss: (_) {
        if (bloc.state.rankings.length > countBefore) {
          _openDetail(context, bloc.state.rankings.last);
        }
      },
      child: SearchRankingToast(),
    );
  }

  void _openDetail(BuildContext context, Ranking ranking) {
    push(context, to: Routes.rankingDetail, object: ranking);
  }
}
