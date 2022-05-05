import 'package:my_movie_app/models/responsives/cast_list.dart';
import 'package:my_movie_app/models/responsives/detail_movie.dart';
import 'package:my_movie_app/models/responsives/popular_movie.dart';
import 'package:my_movie_app/models/responsives/upcoming_movie.dart';
import 'package:my_movie_app/networks/api_client.dart';

abstract class MovieRepository {
  Future<PopularMovie>? getPopularMovie();
  Future<UpcomingMovie>? getUpcomingMovie();
  Future<DetailMovie>? getDetailMovie(String movieID);
  Future<CastList>? getCast(String movieID);
}

class MovieRepositoryImpl extends MovieRepository {
  late ApiClient _apiClient;

  MovieRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<PopularMovie>? getPopularMovie() async {
    return await _apiClient.getPopularMovie();
  }

  @override
  Future<UpcomingMovie>? getUpcomingMovie() async {
    return await _apiClient.getUpcomingMovie();
  }

  @override
  Future<DetailMovie>? getDetailMovie(String movieID) async {
    return await _apiClient.getDetailMovie(movieID);
  }

  @override
  Future<CastList>? getCast(String movieID) async {
    return await _apiClient.getCast(movieID);
  }
}
