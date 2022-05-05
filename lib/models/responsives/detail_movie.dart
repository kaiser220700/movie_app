import 'package:json_annotation/json_annotation.dart';

part 'detail_movie.g.dart';

@JsonSerializable()
class DetailMovie {
  bool? adult;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  List<Genres>? genres;
    @JsonKey(name: "overview")
  final String? overView;
  String? title;
  @JsonKey(name: "vote_average")
  final num? voteAverage;

  DetailMovie({
    this.title,
    this.backdropPath,
    this.genres,
    this.overView,
    this.voteAverage,
  });

  factory DetailMovie.fromJson(Map<String, dynamic> json) => _$DetailMovieFromJson(json);

}

@JsonSerializable()
class Genres {
  String? name;

  Genres({this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

}
