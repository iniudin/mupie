import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:equatable/equatable.dart';

part 'movie_on_playing_event.dart';
part 'movie_on_playing_state.dart';

class MovieOnPlayingBloc
    extends Bloc<MovieOnPlayingEvent, MovieOnPlayingState> {
  final MovieUsecase usecase;

  MovieOnPlayingBloc({required this.usecase}) : super(MovieOnPlayingInitial()) {
    on<GetMovieNowPlaying>((event, emit) async {
      emit(MovieOnPlayingLoading());

      final result = await usecase.getNowPlaying();
      result.fold(
        (error) => emit(MovieOnPlayingError(error.message)),
        (movies) => movies.isNotEmpty
            ? emit(MovieOnPlayingLoaded(movies))
            : emit(const MovieOnPlayingError('Failed')),
      );
    });
  }
}
