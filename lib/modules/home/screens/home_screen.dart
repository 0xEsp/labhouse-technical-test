import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/modules/home/bloc/home_cubit.dart';
import 'package:lab_house/modules/home/components/liquid_glass_bottom_bar.dart';
import 'package:lab_house/modules/config/screens/config_screen.dart';
import 'package:lab_house/modules/ranking/screens/ranking_screen.dart';

class HomeScreen extends StatelessWidget with LocaleManager {
  const HomeScreen({super.key});

  static const _tabs = [RankingScreen(), ConfigScreen()];

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(index: state.currentIndex, children: _tabs),
          bottomNavigationBar: LiquidGlassBottomBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<HomeCubit>().changeTab(index),
            items: [
              LiquidGlassBottomBarItem(
                icon: Icons.home_rounded,
                label: lc.ranking_tap_copy,
              ),
              LiquidGlassBottomBarItem(
                icon: Icons.settings,
                label: lc.config_tap_copy,
              ),
            ],
          ),
        );
      },
    );
  }
}
