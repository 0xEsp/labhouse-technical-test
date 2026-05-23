import 'package:get_it/get_it.dart';

import 'assembly_persistance_mock.dart';

final testContainer = AssemblyMock.shared;

class AssemblyMock {
  final getIt = GetIt.instance;

  /// The one and only instance of this singleton
  static final shared = AssemblyMock._();

  /// Private constructor
  AssemblyMock._();

  void setup() {
    setPersistanceAssemblyMock();
  }

  Future<void> setupCompleted() => getIt.allReady();

  T get<T extends Object>({String? instanceName}) =>
      getIt.get<T>(instanceName: instanceName);

  Future<void> clear() async => await getIt.reset();
}
