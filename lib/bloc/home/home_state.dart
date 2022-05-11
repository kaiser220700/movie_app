part of 'home_cubit.dart';

// ignore: must_be_immutable
class HomeState extends Equatable {
  LoadStatus? loadStatus;
  PopularMovie? popularMovie;
  UpcomingMovie? upcomingMovie;
  bool autoPlay;
  HomeState({
    this.loadStatus,
    this.popularMovie,
    this.upcomingMovie,
    this.autoPlay = false,
  });

  HomeState copyWith({
    LoadStatus? loadStatus,
    PopularMovie? popularMovie,
    UpcomingMovie? upcomingMovie,
    bool? autoPlay,
    int? currentIndex,
    
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      popularMovie: popularMovie ?? this.popularMovie,
      upcomingMovie: upcomingMovie ?? this.upcomingMovie,
      autoPlay: autoPlay ?? this.autoPlay,
    );
  }

  @override
  List<Object?> get props =>
      [loadStatus, popularMovie, upcomingMovie, autoPlay];
}
