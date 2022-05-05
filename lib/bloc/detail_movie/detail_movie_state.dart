part of 'detail_movie_cubit.dart';

// ignore: must_be_immutable
class DetailMovieState extends Equatable {
  LoadStatus? loadStatus;
  DetailMovie? detailMovie;
  CastList? castList;
  Video? video;

  DetailMovieState({
    this.loadStatus,
    this.detailMovie,
    this.castList,
    this.video,
  });

  DetailMovieState copyWith({
    LoadStatus? loadStatus,
    DetailMovie? detailMovie,
    CastList? castList,
    Video? video,
  }) {
    return DetailMovieState(
      loadStatus: loadStatus ?? this.loadStatus,
      detailMovie: detailMovie ?? this.detailMovie,
      castList: castList ?? this.castList,
      video: video ?? this.video,
    );
  }

  @override
  List<Object?> get props => [loadStatus, detailMovie, castList, video];
}
