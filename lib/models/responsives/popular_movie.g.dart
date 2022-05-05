// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularMovie _$PopularMovieFromJson(Map<String, dynamic> json) => PopularMovie(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );



Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      backdropPath: json['backdrop_path'] as String?,
      id: json['id'] as int?,
      title: json['title'] as String?,
      voteAverage: json['vote_average'] as num?,
    );


