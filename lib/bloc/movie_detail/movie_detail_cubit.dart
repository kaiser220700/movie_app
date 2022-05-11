import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie_app/models/load_status.dart';
import 'package:my_movie_app/models/responsives/cast_list.dart';
import 'package:my_movie_app/models/responsives/detail_movie.dart';
import 'package:my_movie_app/models/responsives/video.dart';
import 'package:my_movie_app/repository/movie_repository.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieRepository movieRepository;
  String movieID;
  MovieDetailCubit(this.movieRepository, this.movieID)
      : super(MovieDetailState());

  void init() async {
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try {
      final apiDetailMovie = await movieRepository.getDetailMovie(movieID);
      final apiCast = await movieRepository.getCast(movieID);
      final apiVideo = await movieRepository.getVideo(movieID);
      if (apiDetailMovie != null || apiCast != null || apiVideo != null) {
        emit(state.copyWith(
            detailMovie: apiDetailMovie,
            castList: apiCast,
            video: apiVideo,
            loadStatus: LoadStatus.SUCCESS));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    } catch (e) {
      // ignore: avoid_print
      print("LongNH - error: $e");
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }

  void onPositionIcon(double position, double iconBackHeightCurrent,
      double panelHeightOpen, double panelHeightClosed) {
        double iconBackHeight = iconBackHeightCurrent - position * (panelHeightOpen - panelHeightClosed) / 2;
        emit(state.copyWith(iconBackHeight: iconBackHeight));
  }

}
