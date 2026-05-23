import 'package:flutter/material.dart';

class LoseFocusOnTap extends StatelessWidget {
  final Widget child;

  const LoseFocusOnTap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
