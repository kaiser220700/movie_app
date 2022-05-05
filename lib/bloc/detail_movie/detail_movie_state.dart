part of 'detail_movie_cubit.dart';

// ignore: must_be_immutable
class DetailMovieState extends Equatable {
  LoadStatus? loadStatus;
  DetailMovie? detailMovie;
  CastList? castList;
  Video? video;

  double? iconBackHeight;

  DetailMovieState({
    this.loadStatus,
    this.detailMovie,
    this.castList,
    this.video,
    this.iconBackHeight,
  });

  DetailMovieState copyWith({
    LoadStatus? loadStatus,
    DetailMovie? detailMovie,
    CastList? castList,
    Video? video,
    double? iconBackHeight,
  }) {
    return DetailMovieState(
      loadStatus: loadStatus ?? this.loadStatus,
      detailMovie: detailMovie ?? this.detailMovie,
      castList: castList ?? this.castList,
      video: video ?? this.video,
      iconBackHeight: iconBackHeight ?? this.iconBackHeight,
    );
  }

  @override
  List<Object?> get props => [loadStatus, detailMovie, castList, video, iconBackHeight];
}
