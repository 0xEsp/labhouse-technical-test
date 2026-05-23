part of '../../../core/managers/channel_manager.dart';

abstract class ChannelMethodParams {
  Map<String, dynamic> toParams();
  ChannelMethodParams fromParams(dynamic arguments);
}
