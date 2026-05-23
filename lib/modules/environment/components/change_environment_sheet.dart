import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/common/router/routes.m.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/core/managers/navigation_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/environment/bloc/environment_cubit.dart';
import 'package:lab_house/modules/environment/shared/environment.dart';

class ChangeEnvironmentSheet extends StatelessWidget
    with NavigationManager, LocaleManager {
  // MARK: - Properties

  final _envCubit = EnvironmentCubit();
  final _env = container.get<Environment>();

  // MARK: - Lifecycle

  ChangeEnvironmentSheet({super.key});

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Column(
            children: [
              SegmentedButton<EnvironmentType>(
                showSelectedIcon: false,
                style: SegmentedButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.04),
                  foregroundColor: JGColors.neutralOriginal,
                  selectedForegroundColor: Colors.white,
                  selectedBackgroundColor: JGColors.primaryPurple,
                  overlayColor: Colors.transparent,
                ),
                segments: [
                  ButtonSegment(
                    value: EnvironmentType.technical,
                    tooltip: EnvironmentType.technical.name,
                    icon: Icon(Icons.person_pin_circle_outlined),
                  ),
                ],
                selected: <EnvironmentType>{_env.type},
                onSelectionChanged: (newEnvs) {
                  final newEnv = newEnvs.first;

                  if (newEnv == _env.type) return;

                  _envCubit.changeEnvironment(newEnv);

                  context.pop(true);

                  go(context, to: Routes.home, forceNewInitialRoute: true);
                },
              ),
              Spacer(),
              LabhouseButton(
                text: lc.close,
                onPressed: () => context.pop(false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
