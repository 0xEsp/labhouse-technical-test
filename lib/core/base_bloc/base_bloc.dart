import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:lab_house/assembly/assembly.dart';
import 'package:lab_house/core/cache/cache_storage.dart';
import 'package:lab_house/core/cache/model/cached_decimal_separator.m.dart';
import 'package:lab_house/core/managers/channel_manager.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final _cache = container.get<CacheStorage>();
  final _channelManager = container.get<ChannelManager>();

  BaseBloc() : super(BaseInitial()) {
    on<BaseLoad>(_loadSetup, transformer: droppable());
    on<BaseOnAppear>((event, emit) async => await _handleAppForeground());
  }

  void _loadSetup(BaseLoad event, Emitter<BaseState> emit) async {
    // we could implement generic app starting action's but since this project
    // is just basic and demo for technical test does't need any action
  }

  Future<void> _handleAppForeground() async {
    try {
      final decimalSep = await _channelManager.callNative<String>(
        ChannelMethods.retrieveDeviceDecimalSeparator,
      );
      _cache.save(CachedDecimalSeparator(decimalSep));
    } catch (_) {}
  }
}
