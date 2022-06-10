import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final MovieUsecase usecase;

  MoviePopularBloc({required this.usecase}) : super(MoviePopularInitial()) {
    on<GetPopular>((event, emit) async {
      emit(MoviePopularLoading());

      final result = await usecase.getPopular();
      result.fold(
        (error) => emit(MoviePopularError(error.message)),
        (restaurant) => restaurant.isNotEmpty
            ? emit(MoviePopularLoaded(restaurant))
            : emit(const MoviePopularError('Failed')),
      );
    });
  }
}
