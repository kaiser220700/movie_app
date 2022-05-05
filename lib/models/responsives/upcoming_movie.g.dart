// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingMovie _$UpcomingMovieFromJson(Map<String, dynamic> json) =>
    UpcomingMovie(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Result.fromJson(e as Map<String, dynamic>))
          .toList(),
    );


Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      id: json['id'] as int?,
      posterPath: json['poster_path'] as String?,
    );

