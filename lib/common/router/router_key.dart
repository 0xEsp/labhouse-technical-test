import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_house/common/router/routes.m.dart';
import 'package:lab_house/extensions/router/router_builder_generation.dart';

final GlobalKey<NavigatorState> routerKey = GlobalKey();
final routes = Routes.values
    .where((route) => route.path.startsWith("/"))
    .map((r) => r.builder.flow())
    .toList();

final router = GoRouter(
  navigatorKey: routerKey,
  initialLocation: Routes.home.path,
  debugLogDiagnostics: true,
  routes: routes,
);
