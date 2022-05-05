
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/models/load_status.dart';
import 'package:my_movie_app/models/responsives/cast_list.dart';
import 'package:my_movie_app/models/responsives/detail_movie.dart';
import 'package:my_movie_app/models/responsives/video.dart';
import 'package:my_movie_app/repository/movie_repository.dart';

part 'detail_movie_state.dart';

class DetailMovieCubit extends Cubit<DetailMovieState> {
  MovieRepository movieRepository;
  String movieID;
  DetailMovieCubit(this.movieRepository, this.movieID) : super(DetailMovieState());

  void init() async {
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try {
      final apiDetailMovie = await movieRepository.getDetailMovie(movieID);
      final apiCast = await movieRepository.getCast(movieID);
      final apiVideo = await movieRepository.getVideo(movieID);
      if ( apiDetailMovie != null || apiCast != null || apiVideo != null) {
        emit(state.copyWith(detailMovie: apiDetailMovie,castList: apiCast, video: apiVideo,loadStatus: LoadStatus.SUCCESS));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    } catch (e) {
      // ignore: avoid_print
      print("LongNH - error: $e");
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }
}