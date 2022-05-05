import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/bloc/movie/movie_cubit.dart';
import 'package:my_movie_app/networks/api_client.dart';
import 'package:my_movie_app/networks/api_util.dart';
import 'package:my_movie_app/repository/movie_repository.dart';
import 'package:my_movie_app/ui/screens/home_screen.dart';

void main() {
  late final ApiClient _apiClient;
  _apiClient = ApiUtil.instance.apiClient;
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRepository>(create: (context) {
          return MovieRepositoryImpl(_apiClient);
        })
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieCubit>(create: (context) {
            final repository = RepositoryProvider.of<MovieRepository>(context);
            return MovieCubit(repository);
          }),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      )));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}
