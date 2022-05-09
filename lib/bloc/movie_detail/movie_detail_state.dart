part of 'movie_detail_cubit.dart';

// ignore: must_be_immutable
class MovieDetailState extends Equatable {
  LoadStatus? loadStatus;
  DetailMovie? detailMovie;
  CastList? castList;
  Video? video;

  double? iconBackHeight;

  MovieDetailState({
    this.loadStatus,
    this.detailMovie,
    this.castList,
    this.video,
    this.iconBackHeight,
  });

  MovieDetailState copyWith({
    LoadStatus? loadStatus,
    DetailMovie? detailMovie,
    CastList? castList,
    Video? video,
    double? iconBackHeight,
  }) {
    return MovieDetailState(
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
