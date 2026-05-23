import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/shared_preference_option.m.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/modules/config/model/app_language.m.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChangeLanguageUseCase {
  Future<void> execute(AppLanguage language);
}

class ChangeLanguageUseCaseDefault implements ChangeLanguageUseCase {
  // MARK: - Properties

  final _appSettings = container.get<AppSettingsManager>();
  final _preferences = container.get<SharedPreferencesAsync>();

  // MARK: - Public Methods

  @override
  Future<void> execute(AppLanguage language) async {
    await _preferences.setString(
      SharedPreferenceOption.language.name,
      language.code,
    );

    _appSettings.updateLanguage(language);
  }
}
