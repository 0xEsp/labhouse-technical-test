import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/core/managers/secrets_manager.dart';
import 'package:lab_house/extensions/string/string_suffix.dart';
import 'package:lab_house/modules/config/model/app_language.m.dart';
import 'package:lab_house/modules/config/model/app_theme_mode.m.dart';
import 'package:lab_house/modules/config/usecases/change_language_usecase.dart';
import 'package:lab_house/modules/config/usecases/change_theme_usecase.dart';
import 'package:lab_house/modules/config/usecases/save_api_key_usecase.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  // MARK: - Properties

  final _changeThemeUseCase = container.get<ChangeThemeUseCase>();
  final _changeLanguageUseCase = container.get<ChangeLanguageUseCase>();
  final _saveApiKeyUseCase = container.get<SaveApiKeyUseCase>();

  // MARK: - Lifecycle

  SettingsCubit() : super(_initialState());

  /// Seeds the UI from the live values already resolved at app load
  static SettingsState _initialState() {
    final settings = container.get<AppSettingsManager>();
    final secrets = container.get<SecretsManager>();

    return SettingsState(
      themeMode: settings.themeMode,
      language: settings.language,
      apiKey: secrets.get(Secret.openaiApiKey),
    );
  }

  // MARK: - Public Methods

  Future<void> changeTheme(AppThemeMode mode) async {
    await _changeThemeUseCase.execute(mode);

    emit(state.copyWith(themeMode: mode));
  }

  Future<void> changeLanguage(AppLanguage language) async {
    await _changeLanguageUseCase.execute(language);

    emit(state.copyWith(language: language));
  }

  Future<void> saveApiKey(String apiKey) async {
    await _saveApiKeyUseCase.execute(apiKey);

    emit(state.copyWith(apiKey: apiKey));
  }
}
