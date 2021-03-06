// ignore_for_file: avoid_print

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/models/load_status.dart';
import 'package:my_movie_app/models/responsives/popular_movie.dart';
import 'package:my_movie_app/models/responsives/upcoming_movie.dart';
import 'package:my_movie_app/repository/movie_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  MovieRepository movieRepository;

  HomeCubit(this.movieRepository) : super(HomeState());

  void init() async {
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try {
      final apiPopularMovie = await movieRepository.getPopularMovie();
      final apiUpcomingMovie = await movieRepository.getUpcomingMovie();
      if (apiPopularMovie != null || apiUpcomingMovie != null) {
        emit(state.copyWith(
            popularMovie: apiPopularMovie,
            upcomingMovie: apiUpcomingMovie,
            loadStatus: LoadStatus.SUCCESS));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    } catch (e,s) {
      print("LongNH - error: $e");
      print("LongNH - stack trace: $s");
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }

  void onAutoPlay(bool autoPlay) {
    autoPlay = !autoPlay;
    emit(state.copyWith(autoPlay: autoPlay));
  }
}