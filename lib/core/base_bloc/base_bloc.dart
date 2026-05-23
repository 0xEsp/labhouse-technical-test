import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/shared_preference_option.m.dart';
import 'package:lab_house/core/cache/cache_storage.dart';
import 'package:lab_house/core/cache/model/cached_decimal_separator.m.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/core/managers/channel_manager.dart';
import 'package:lab_house/modules/config/model/app_language.m.dart';
import 'package:lab_house/modules/config/model/app_theme_mode.m.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  // MARK: - Properties

  final _cache = container.get<CacheStorage>();
  final _channelManager = container.get<ChannelManager>();
  final _preferences = container.get<SharedPreferencesAsync>();
  final _appSettings = container.get<AppSettingsManager>();

  // MARK: - Lifecycle

  BaseBloc() : super(BaseInitial()) {
    on<BaseLoad>(_loadSetup, transformer: droppable());
    on<BaseOnAppear>((event, emit) async => await _handleAppForeground());
  }

  // MARK: - Event Methods

  void _loadSetup(BaseLoad event, Emitter<BaseState> emit) async {
    await _restoreAppSettings();
  }

  Future<void> _handleAppForeground() async {
    try {
      final decimalSep = await _channelManager.callNative<String>(
        ChannelMethods.retrieveDeviceDecimalSeparator,
      );
      _cache.save(CachedDecimalSeparator(decimalSep));
    } catch (_) {}
  }

  // MARK: - Private Methods

  Future<void> _restoreAppSettings() async {
    final themeName = await _preferences.getString(
      SharedPreferenceOption.theme.name,
    );
    final languageCode = await _preferences.getString(
      SharedPreferenceOption.language.name,
    );

    _appSettings.updateThemeMode(AppThemeMode.fromName(themeName));
    _appSettings.updateLanguage(AppLanguage.fromCode(languageCode));
  }
}
