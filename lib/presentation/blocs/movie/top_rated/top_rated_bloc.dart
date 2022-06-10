import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final MovieUsecase usecase;

  MovieTopRatedBloc({required this.usecase}) : super(MovieTopRatedInitial()) {
    on<GetTopRated>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await usecase.getTopRated();
      result.fold(
        (error) => emit(MovieTopRatedError(error.message)),
        (restaurant) => restaurant.isNotEmpty
            ? emit(MovieTopRatedLoaded(restaurant))
            : emit(const MovieTopRatedError('Failed')),
      );
    });
  }
}
