import 'package:json_annotation/json_annotation.dart';

part 'popular_movie.g.dart';

@JsonSerializable()
class PopularMovie {
  
  List<Result>? results;

  PopularMovie({this.results});

factory PopularMovie.fromJson(Map<String, dynamic> json) => _$PopularMovieFromJson(json);
}

@JsonSerializable()
class Result {
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  int? id;
  String? title;

  @JsonKey(name: "vote_average")
  num? voteAverage;

  Result ({this.backdropPath, this.id, this.title, this.voteAverage});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

}
