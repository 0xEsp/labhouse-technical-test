import 'package:flutter/material.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/common/presentation/loading/spinner.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/config/model/app_theme_mode.m.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The launch screen renders outside `MaterialApp`, so `Theme.of` isn't the
    // app theme yet. Resolve the background from the live appearance setting
    // (already seeded from the system on first run).
    final isDark =
        container.get<AppSettingsManager>().themeMode == AppThemeMode.dark;

    return Scaffold(
      backgroundColor: isDark ? JGColors.darkBackground : JGColors.primaryWhite,
      body: const Spinner(),
    );
  }
}
