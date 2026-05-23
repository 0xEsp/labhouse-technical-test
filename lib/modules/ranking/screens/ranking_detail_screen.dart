import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/appbar/labhouse_app_bar.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';

class RankingDetailScreen extends StatelessWidget {
  final Ranking ranking;

  const RankingDetailScreen({super.key, required this.ranking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LabhouseAppBar(title: ranking.topicName),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            ranking.topicName,
            textAlign: TextAlign.center,
            style: LabhouseTextTheme.semibold(size: 22),
          ),
        ),
      ),
    );
  }
}
