import 'package:dio/dio.dart';
import 'package:my_movie_app/models/responsives/cast_list.dart';
import 'package:my_movie_app/models/responsives/detail_movie.dart';
import 'package:my_movie_app/models/responsives/popular_movie.dart';
import 'package:my_movie_app/models/responsives/upcoming_movie.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

const apiKey = "26763d7bf2e94098192e629eb975dab0";
const baseUrl = "https://api.themoviedb.org/3";

@RestApi(baseUrl: baseUrl)

abstract class ApiClient {
 
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

 @GET('/movie/popular?api_key=$apiKey')
 Future<PopularMovie> getPopularMovie();

 @GET('/movie/upcoming?api_key=$apiKey')
 Future<UpcomingMovie> getUpcomingMovie();

// ('$baseUrl/movie/$movieID/videos?$apiKey')


 @GET('/movie/{movie_id}?api_key=$apiKey')
 Future<DetailMovie> getDetailMovie(@Path("movie_id") String movieID);

 @GET(('/movie/{movie_id}/credits?api_key=$apiKey'))
  Future<CastList> getCast(@Path("movie_id") String movieID);
}
