import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/api/model/shared_preference_option.m.dart';
import 'package:lab_house/core/data_service.dart';
import 'package:lab_house/modules/environment/shared/environment.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChangeEnvironmentUseCase {
  void execute(EnvironmentType env);
}

class ChangeEnvironmentUseCaseDefault implements ChangeEnvironmentUseCase {
  // MARK: - Properties

  final _environment = container.get<Environment>();
  final _apiService = container.get<ApiService>();
  final _preferences = container.get<SharedPreferencesAsync>();

  // MARK: - Public Methods

  @override
  void execute(EnvironmentType env) {
    _environment.update(env);
    _apiService.updateEnvironmentUrl(env.baseUrl());
    _preferences.setString(SharedPreferenceOption.env.name, env.name);
  }
}
