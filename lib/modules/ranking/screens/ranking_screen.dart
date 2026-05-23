import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/modules/ranking/bloc/ranking_bloc.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RankingBloc, RankingState>(
      builder: (context, state) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF0F172A), Color(0xFF111827)],
                ),
              ),
            ),
            Positioned(
              left: -40,
              bottom: 0,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x8CDA70D6),
                ),
              ),
            ),
            Positioned(
              right: -20,
              bottom: 40,
              child: Container(
                width: 180,
                height: 180,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x8C20B2AA),
                ),
              ),
            ),
            Center(
              child: SizedBox(
                height: 60,
                width: 200,
                child: LabhouseButton(
                  text: 'pruebas',
                  onPressed: () => context.read<RankingBloc>().add(
                    RankingGeneration(
                      query: 'Give me the most 10 books of entrepreneurship',
                      model: .gpt4oMini,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
