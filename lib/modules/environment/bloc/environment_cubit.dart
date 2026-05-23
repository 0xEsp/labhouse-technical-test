import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/modules/environment/shared/environment.dart';
import 'package:lab_house/modules/environment/usecases/change_environment_usecase.dart';

class EnvironmentCubit extends Cubit<void> {
  // MARK: - Properties

  final _changeEnvironmentUseCase = container.get<ChangeEnvironmentUseCase>();

  // MARK: - Lifecycle

  EnvironmentCubit() : super(null);

  // MARK: - Public Methods

  void changeEnvironment(EnvironmentType env) {
    _changeEnvironmentUseCase.execute(env);
  }
}
