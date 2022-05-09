// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailMovie _$DetailMovieFromJson(Map<String, dynamic> json) => DetailMovie(
      title: json['title'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genres.fromJson(e as Map<String, dynamic>))
          .toList(),
      overView: json['overview'] as String?,
      voteAverage: json['vote_average'] as num?,
    )..adult = json['adult'] as bool?;



Genres _$GenresFromJson(Map<String, dynamic> json) => Genres(
      name: json['name'] as String?,
    );

