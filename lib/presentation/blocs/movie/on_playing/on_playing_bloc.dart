import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:equatable/equatable.dart';

part 'on_playing_event.dart';
part 'on_playing_state.dart';

class MovieOnPlayingBloc
    extends Bloc<MovieOnPlayingEvent, MovieOnPlayingState> {
  final MovieUsecase usecase;

  MovieOnPlayingBloc({required this.usecase}) : super(MovieOnPlayingInitial()) {
    on<GetNowPlaying>((event, emit) async {
      emit(MovieOnPlayingLoading());

      final result = await usecase.getNowPlaying();
      result.fold(
        (error) => emit(MovieOnPlayingError(error.message)),
        (restaurant) => restaurant.isNotEmpty
            ? emit(MovieOnPlayingLoaded(restaurant))
            : emit(const MovieOnPlayingError('Failed')),
      );
    });
  }
}
