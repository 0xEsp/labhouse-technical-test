import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/modules/environment/shared/environment.dart';

extension CommonAssembly on Assembly {
  void setCommonAssembly() {
    getIt.registerSingleton(Environment());
  }
}
