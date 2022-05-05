import 'package:dio/dio.dart';
import 'api_client.dart';
import 'api_interceptors.dart';

class ApiUtil {
  late final Dio dio;
  late final ApiClient apiClient;

  ApiUtil._privateConstructor() {
    dio = Dio();
    dio.options.connectTimeout = 15000;
    dio.interceptors.add(ApiInterceptors());
    apiClient = ApiClient(dio, baseUrl: "https://api.themoviedb.org/3");
  }

  static final ApiUtil instance = ApiUtil._privateConstructor();
}