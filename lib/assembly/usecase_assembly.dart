import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/modules/environment/usecases/change_environment_usecase.dart';

extension UseCaseAssembly on Assembly {
  void setUseCaseAssembly() {
    // MARK: - Environment

    getIt.registerLazySingleton<ChangeEnvironmentUseCase>(
      () => ChangeEnvironmentUseCaseDefault(),
    );
  }
}
