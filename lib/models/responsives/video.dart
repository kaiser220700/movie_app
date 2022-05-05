import 'package:json_annotation/json_annotation.dart';

part 'video.g.dart';

@JsonSerializable()
class Video {
  List<Result>? results;

  Video({this.results});

    factory Video.fromJson(Map<String, dynamic> json) =>
      _$VideoFromJson(json);
}

@JsonSerializable()
class Result {
  String? key;
  Result({this.key});
  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);
}