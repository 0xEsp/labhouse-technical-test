import 'dart:async';

import 'package:flutter/services.dart';

part '../../common/model/channel/channel_methods_params.m.dart';
part '../../common/model/channel/channel_methods.m.dart';

class ChannelManager {
  static const _platform = MethodChannel('labhouse.flutter.config/channel');

  Future<T> callNative<T>(
    ChannelMethods method, {
    ChannelMethodParams? extra,
  }) async {
    return await _platform.invokeMethod(
      method.rawValue,
      extra == null ? null : method.toParams(extra),
    );
  }

  var _streamController = StreamController<ChannelMethodParams?>.broadcast();

  Stream<ChannelMethodParams?> reactToCallNative({
    required ChannelMethods method,
  }) {
    if (_streamController.isClosed) {
      _streamController = StreamController<ChannelMethodParams?>.broadcast();
    }

    _platform.setMethodCallHandler((call) async {
      if (call.method != method.rawValue) return;

      final channelMethodParams = method.fromParams(call.arguments);

      _streamController.add(channelMethodParams);
    });

    return _streamController.stream.asBroadcastStream();
  }

  void dispose() => unawaited(_streamController.close());
}
