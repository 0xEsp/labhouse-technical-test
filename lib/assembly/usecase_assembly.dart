import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/modules/config/usecases/change_language_usecase.dart';
import 'package:lab_house/modules/config/usecases/change_theme_usecase.dart';
import 'package:lab_house/modules/config/usecases/save_api_key_usecase.dart';
import 'package:lab_house/modules/environment/usecases/change_environment_usecase.dart';
import 'package:lab_house/modules/ranking/usecases/generate_ranking_usecase.dart';
import 'package:lab_house/modules/ranking/usecases/get_rankings_usecase.dart';

extension UseCaseAssembly on Assembly {
  void setUseCaseAssembly() {
    // MARK: - Environment

    getIt.registerLazySingleton<ChangeEnvironmentUseCase>(
      () => ChangeEnvironmentUseCaseDefault(),
    );

    // MARK: - Settings

    getIt.registerLazySingleton<ChangeThemeUseCase>(
      () => ChangeThemeUseCaseDefault(),
    );

    getIt.registerLazySingleton<ChangeLanguageUseCase>(
      () => ChangeLanguageUseCaseDefault(),
    );

    getIt.registerLazySingleton<SaveApiKeyUseCase>(
      () => SaveApiKeyUseCaseDefault(),
    );

    // MARK: - Ranking

    getIt.registerLazySingleton<GenerateRankingUseCase>(
      () => GenerateRankingUseCaseDefault(),
    );

    getIt.registerLazySingleton<GetRankingsUseCase>(
      () => GetRankingsUseCaseDefault(),
    );
  }
}
