part of 'home_cubit.dart';

class HomeState extends Equatable {
  // MARK: - Properties

  final int currentIndex;

  // MARK: - Lifecycle

  const HomeState({this.currentIndex = 0});

  // MARK: - Copy

  HomeState copyWith({int? currentIndex}) =>
      HomeState(currentIndex: currentIndex ?? this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
