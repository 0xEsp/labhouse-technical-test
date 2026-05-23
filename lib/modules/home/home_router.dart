import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lab_house/common/router/router_builder.dart';
import 'package:lab_house/common/router/routes.m.dart';
import 'package:lab_house/modules/home/bloc/home_bloc.dart';

import 'package:lab_house/modules/home/screens/home_screen.dart';

class HomeRouter implements RouterBuilder {
  // MARK: - Properties

  static final shared = HomeRouter._();

  // MARK: - Lifecycle

  HomeRouter._();

  // MARK: - Public Methods

  @override
  GoRoute flow() {
    return GoRoute(
      path: Routes.home.path,
      name: Routes.home.name,
      builder: (_, _) => BlocProvider<HomeBloc>(
        create: (_) => HomeBloc()..add(HomeLoad()),
        child: HomeScreen(),
      ),
    );
  }
}
