import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/managers/app_settings_manager.dart';
import 'package:lab_house/core/managers/channel_manager.dart';
import 'package:lab_house/core/managers/connection_manager.dart';
import 'package:lab_house/core/managers/secrets_manager.dart';
import 'package:lab_house/core/secure/secure_storage.dart';

extension ManagerAssembly on Assembly {
  void setManagerAssembly() {
    // MARK: - Connection Manager

    getIt.registerSingleton<ConnectionManager>(
      ConnectionManager(),
      dispose: (manager) => manager.dispose(),
    );

    // MARK: - App Settings Manager

    getIt.registerSingleton<AppSettingsManager>(
      AppSettingsManager(),
      dispose: (manager) => manager.dispose(),
    );

    // MARK: - Secrets Manager

    getIt.registerSingletonAsync<SecretsManager>(
      () async => await SecretsManager.init(),
      dependsOn: [SecureStorage],
    );

    // MARK: - Channel Manager

    getIt.registerSingleton<ChannelManager>(
      ChannelManager(),
      dispose: (manager) => manager.dispose(),
    );
  }
}
