import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';
import 'package:lab_house/modules/home/bloc/home_bloc.dart';
import 'package:lab_house/modules/home/components/liquid_glass_bottom_bar.dart';
import 'package:lab_house/modules/config/screens/config_screen.dart';
import 'package:lab_house/modules/ranking/screens/ranking_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with LocaleManager {
  int _currentIndex = 0;

  AppLocalizations get _lc => locale(context);

  final _tabs = const [RankingScreen(), ConfigScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(index: _currentIndex, children: _tabs),
          bottomNavigationBar: LiquidGlassBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            items: [
              LiquidGlassBottomBarItem(
                icon: Icons.home_rounded,
                label: _lc.ranking_tap_copy,
              ),
              LiquidGlassBottomBarItem(
                icon: Icons.settings,
                label: _lc.config_tap_copy,
              ),
            ],
          ),
        );
      },
    );
  }
}
