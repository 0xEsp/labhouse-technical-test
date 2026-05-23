import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/managers/channel_manager.dart';
import 'package:lab_house/core/managers/connection_manager.dart';
import 'package:lab_house/core/managers/secrets_manager.dart';

extension ManagerAssembly on Assembly {
  void setManagerAssembly() {
    // MARK: - Connection Manager

    getIt.registerSingleton<ConnectionManager>(
      ConnectionManager(),
      dispose: (manager) => manager.dispose(),
    );

    // MARK: - Secrets Manager

    getIt.registerSingleton<SecretsManager>(SecretsManager());

    // MARK: - Channel Manager

    getIt.registerSingleton<ChannelManager>(
      ChannelManager(),
      dispose: (manager) => manager.dispose(),
    );
  }
}
