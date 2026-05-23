part of '../../../core/managers/channel_manager.dart';

enum ChannelMethods {
  // Flutter -> Native
  listenShakeAction,
  retrieveDeviceDecimalSeparator,
  // Native -> Flutter
  onShakeDevice,
}

extension ChannelMethodsExtension on ChannelMethods {
  String get rawValue {
    switch (this) {
      case ChannelMethods.listenShakeAction:
        return 'listenShakeDeviceAction';
      case ChannelMethods.retrieveDeviceDecimalSeparator:
        return 'getDeviceDecimalSeparator';
      case ChannelMethods.onShakeDevice:
        return 'onShakeDevice';
    }
  }

  Map<String, dynamic> toParams(ChannelMethodParams model) => model.toParams();

  ChannelMethodParams? fromParams(dynamic arguments) => switch (this) {
    _ => null,
  };
}
