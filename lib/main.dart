import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/base_bloc/base_bloc.dart';
import 'package:lab_house/labhouse_app.dart';
import 'package:lab_house/modules/config/bloc/settings_cubit.dart';
import 'package:lab_house/modules/home/bloc/home_cubit.dart';
import 'package:lab_house/modules/ranking/bloc/ranking_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  container.setup();
  await container.setupCompleted();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BaseBloc()),
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => RankingBloc()..add(RankingFetch())),
        BlocProvider(create: (_) => SettingsCubit()),
      ],
      child: LabhouseApp(),
    ),
  );
}
