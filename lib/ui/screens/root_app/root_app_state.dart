// ignore_for_file: must_be_immutable

part of 'root_app_cubit.dart';

class RootAppState extends Equatable{
  int selectedIndex;

  RootAppState({
    this.selectedIndex = 0,
  });

  RootAppState copyWith ({
    int? selectedIndex,
  }){
    return RootAppState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  } 

  @override
  List<Object?> get props => [selectedIndex];

}