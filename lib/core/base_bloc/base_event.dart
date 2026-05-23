part of 'base_bloc.dart';

sealed class BaseEvent extends Equatable {
  const BaseEvent();

  @override
  List<Object> get props => [];
}

final class BaseLoad extends BaseEvent {}

final class BaseOnAppear extends BaseEvent {}
