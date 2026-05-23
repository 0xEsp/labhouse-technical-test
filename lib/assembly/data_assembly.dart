import 'package:dio/dio.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/data_service.dart';
import 'package:lab_house/core/api/interceptor_log.dart';

extension DataAssembly on Assembly {
  void setDataAssembly() {
    // MARK: - Network

    getIt.registerLazySingleton<ApiService>(() => ApiServiceDefault());

    getIt.registerSingleton<Dio>(Dio()..interceptors.add(InterceptorLogs()));
  }
}
