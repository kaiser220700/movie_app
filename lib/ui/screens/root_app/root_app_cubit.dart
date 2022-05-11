import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'root_app_state.dart';

class RootAppCubit extends Cubit<RootAppState> {
  RootAppCubit() : super(RootAppState());

  void switchTap(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
