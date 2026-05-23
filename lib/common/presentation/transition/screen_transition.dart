import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum ScreenTransition {
  present,
  stack;

  Page<dynamic> page(
    BuildContext context,
    GoRouterState state, {
    required Widget screen,
  }) => switch (this) {
    ScreenTransition.present => CustomTransitionPage(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCirc));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ),
    ScreenTransition.stack => CustomTransitionPage(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.ease));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ),
  };
}
