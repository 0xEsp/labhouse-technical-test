import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/shared_preference_option.m.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/modules/config/model/app_theme_mode.m.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChangeThemeUseCase {
  Future<void> execute(AppThemeMode mode);
}

class ChangeThemeUseCaseDefault implements ChangeThemeUseCase {
  // MARK: - Properties

  final _appSettings = container.get<AppSettingsManager>();
  final _preferences = container.get<SharedPreferencesAsync>();

  // MARK: - Public Methods

  @override
  Future<void> execute(AppThemeMode mode) async {
    await _preferences.setString(SharedPreferenceOption.theme.name, mode.name);

    _appSettings.updateThemeMode(mode);
  }
}
