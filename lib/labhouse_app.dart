import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/common/lazy.dart';
import 'package:lab_house/common/presentation/state/life_cycle_handler.dart';
import 'package:lab_house/common/router/router_key.dart';
import 'package:lab_house/core/base_bloc/base_bloc.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/core/managers/channel_manager.dart';
import 'package:lab_house/core/managers/navigation_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';
import 'package:lab_house/modules/environment/components/change_environment_sheet.dart';
import 'package:lab_house/modules/environment/shared/environment.dart';
import 'package:lab_house/modules/launch/launch_screen.dart';

class LabhouseApp extends StatefulWidget {
  const LabhouseApp({super.key});

  @override
  State<LabhouseApp> createState() => _LabhouseAppState();
}

class _LabhouseAppState extends State<LabhouseApp> with NavigationManager {
  // MARK: - Properties

  late final Lazy<Environment> _environment = Lazy(
    () => container.get<Environment>(),
  );

  final _channelManager = container.get<ChannelManager>();
  final _appSettings = container.get<AppSettingsManager>();

  bool _canPresentChangeEnvSheet = true;

  // MARK: - Lifecycle

  @override
  void reassemble() {
    super.reassemble();

    _canPresentChangeEnvSheet = false;

    _enablePresentEnvSheetAgainWithDelay();
  }

  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    // Rebuilds whenever the user changes appearance/language so the whole app
    // re-themes and re-localizes live.
    final app = ListenableBuilder(
      listenable: _appSettings,
      builder: (context, _) => MaterialApp.router(
        title: 'Labhouse',
        theme: LabhouseTheme.light,
        darkTheme: LabhouseTheme.dark,
        themeMode: _appSettings.materialThemeMode,
        locale: _appSettings.locale,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );

    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: LifeCycleHandler(
            onFocusGained: () => context.read<BaseBloc>().add(BaseOnAppear()),
            child: FutureBuilder(
              future: container.setupCompleted(),
              builder: (context, diSnapshot) {
                if (diSnapshot.data == null) return LaunchScreen();

                // It is not necessary to handle it within _appLoaded because the bloc manage duplicates itself.
                context.read<BaseBloc>().add(BaseLoad());

                return StreamBuilder(
                  initialData: false,
                  stream: _channelManager.reactToCallNative(
                    method: ChannelMethods.onShakeDevice,
                  ),
                  builder: (context, snapshot) {
                    switch (snapshot.data) {
                      /// initial
                      case false:
                        _channelManager.callNative(
                          ChannelMethods.listenShakeAction,
                        );
                        break;

                      /// shake response
                      case null:
                        if (!_canPresentChangeEnvSheet) break;

                        _canPresentChangeEnvSheet = false;

                        nativeSheet<bool>(
                          routerKey.currentContext ?? context,
                          child: ChangeEnvironmentSheet(),
                          onDismiss: (changed) {
                            _enablePresentEnvSheetAgainWithDelay();

                            if (changed != true) return;

                            // reset _environment in order to refresh top right environment banner
                            setState(() {});
                          },
                        );
                    }

                    return Banner(
                      message: _environment.value.type.name,
                      color: _environment.value.type.envColor(),
                      location: BannerLocation.topEnd,
                      child: app,
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  // MARK: - Private Methods

  void _enablePresentEnvSheetAgainWithDelay() => Future.delayed(
    const Duration(seconds: 1),
    () => _canPresentChangeEnvSheet = true,
  );
}
