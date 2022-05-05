part of 'movie_cubit.dart';

// ignore: must_be_immutable
class MovieState extends Equatable {
  LoadStatus? loadStatus;
  PopularMovie? popularMovie;
  UpcomingMovie? upcomingMovie;

  MovieState({
    this.loadStatus,
    this.popularMovie,
    this.upcomingMovie,
  });

  MovieState copyWith({
    LoadStatus? loadStatus,
    PopularMovie? popularMovie,
    UpcomingMovie? upcomingMovie,
  }) {
    return MovieState(
      loadStatus: loadStatus ?? this.loadStatus,
      popularMovie: popularMovie ?? this.popularMovie,
      upcomingMovie: upcomingMovie ?? this.upcomingMovie,
    );
  }

  @override
  List<Object?> get props => [loadStatus, popularMovie, upcomingMovie];

}