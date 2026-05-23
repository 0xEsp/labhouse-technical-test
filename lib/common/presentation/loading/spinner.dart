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
        'assets/animations/loading.json',
        fit: BoxFit.cover,
        animate: true,
      ),
    );
  }
}
