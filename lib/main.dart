import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/bloc/home/home_cubit.dart';
import 'package:my_movie_app/networks/api_client.dart';
import 'package:my_movie_app/networks/api_util.dart';
import 'package:my_movie_app/repository/movie_repository.dart';
import 'package:my_movie_app/ui/screens/root_app/root_app_cubit.dart';
import 'package:my_movie_app/ui/screens/root_app/root_app_view.dart';

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
          BlocProvider<HomeCubit>(
            create: (context) {
              final repository =
                  RepositoryProvider.of<MovieRepository>(context);
              return HomeCubit(repository);
            },
          ),
          BlocProvider<RootAppCubit>(
            create: (context) => RootAppCubit(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RootApp(),
        ),
      )));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}
