part of 'movie_cubit.dart';

// ignore: must_be_immutable
class MovieState extends Equatable {
  LoadStatus? loadStatus;
  PopularMovie? popularMovie;
  UpcomingMovie? upcomingMovie;
  bool? autoPlay;

  MovieState({
    this.loadStatus,
    this.popularMovie,
    this.upcomingMovie,
    this.autoPlay,
  });

  MovieState copyWith({
    LoadStatus? loadStatus,
    PopularMovie? popularMovie,
    UpcomingMovie? upcomingMovie,
    bool? autoPlay,
  }) {
    return MovieState(
      loadStatus: loadStatus ?? this.loadStatus,
      popularMovie: popularMovie ?? this.popularMovie,
      upcomingMovie: upcomingMovie ?? this.upcomingMovie,
      autoPlay: autoPlay ?? this.autoPlay
    );
  }

  @override
  List<Object?> get props => [loadStatus, popularMovie, upcomingMovie, autoPlay];

}