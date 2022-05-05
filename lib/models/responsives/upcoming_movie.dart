import 'package:json_annotation/json_annotation.dart';

part 'upcoming_movie.g.dart';

@JsonSerializable()
class UpcomingMovie {
  
  List<Result>? results;

 UpcomingMovie({this.results});

factory UpcomingMovie.fromJson(Map<String, dynamic> json) => _$UpcomingMovieFromJson(json);
}

@JsonSerializable()
class Result {
  int? id;
  @JsonKey(name: "poster_path")
  String? posterPath;


  Result ({this.id, this.posterPath});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

}
