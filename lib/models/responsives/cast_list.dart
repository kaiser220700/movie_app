import 'package:json_annotation/json_annotation.dart';

part 'cast_list.g.dart';

@JsonSerializable()
class CastList {
  List<Cast>? cast;

  CastList(this.cast);

  factory CastList.fromJson(Map<String, dynamic> json) =>
      _$CastListFromJson(json);
}

@JsonSerializable()
class Cast {
  String? name;
  @JsonKey(name: "profile_path")
  String? profilePath;
  String? character;

  Cast({this.name, this.profilePath, this.character});

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);
}
