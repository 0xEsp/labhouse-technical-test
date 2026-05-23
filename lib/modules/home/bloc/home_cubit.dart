import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  // MARK: - Lifecycle

  HomeCubit() : super(const HomeState());

  // MARK: - Public Methods

  void changeTab(int index) => emit(state.copyWith(currentIndex: index));
}
