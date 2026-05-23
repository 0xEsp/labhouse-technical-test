import 'package:flutter/material.dart';
import 'package:lab_house/common/presentation/loading/spinner.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: JGColors.primaryPurple, body: Spinner());
  }
}
