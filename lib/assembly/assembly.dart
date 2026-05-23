import 'package:get_it/get_it.dart';
import 'package:lab_house/assembly/common_assembly.dart';
import 'package:lab_house/assembly/data_assembly.dart';
import 'package:lab_house/assembly/manager_assembly.dart';
import 'package:lab_house/assembly/persistance_assembly.dart';
import 'package:lab_house/assembly/usecase_assembly.dart';

final container = Assembly.shared;

class Assembly {
  final getIt = GetIt.instance;

  /// The one and only instance of this singleton
  static final shared = Assembly._();

  /// Private constructor
  Assembly._();

  void setup() {
    setPersistanceAssembly();
    setCommonAssembly();
    setManagerAssembly();
    setDataAssembly();
    setUseCaseAssembly();
  }

  Future<bool> setupCompleted() async {
    await getIt.allReady();

    return true;
  }

  T get<T extends Object>({String? instanceName}) =>
      getIt.get<T>(instanceName: instanceName);

  Future<void> clear() async => getIt.reset();
}
