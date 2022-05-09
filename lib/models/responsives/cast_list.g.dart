// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastList _$CastListFromJson(Map<String, dynamic> json) => CastList(
      (json['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
    );



Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      name: json['name'] as String?,
      profilePath: json['profile_path'] as String?,
      character: json['character'] as String?,
    );

