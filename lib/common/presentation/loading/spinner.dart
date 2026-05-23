import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Spinner extends StatelessWidget {
  // MARK: - Lifecycle

  const Spinner({super.key});

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        // TODO: create logo lottie animation with white color
        'assets/animations/logo_white.json',
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        animate: true,
      ),
    );
  }
}
