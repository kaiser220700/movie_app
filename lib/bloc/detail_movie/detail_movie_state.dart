part of 'detail_movie_cubit.dart';

// ignore: must_be_immutable
class DetailMovieState extends Equatable {
  LoadStatus? loadStatus;
  DetailMovie? detailMovie;
    CastList? castList;

  DetailMovieState({
    this.loadStatus,
    this.detailMovie,
    this.castList,
  });

  DetailMovieState copyWith({
    LoadStatus? loadStatus,
    DetailMovie? detailMovie,
    CastList? castList,

  }) {
    return DetailMovieState(
      loadStatus: loadStatus ?? this.loadStatus,
      detailMovie: detailMovie ?? this.detailMovie,
      castList: castList ?? this.castList
    );
  }

  @override
  List<Object?> get props => [loadStatus, detailMovie, castList];

}