import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final DetailUsecase usecase;
  MovieDetailBloc({
    required this.usecase,
  }) : super(MovieDetailInitial()) {
    on<GetDetailMovie>(
      (event, emit) async {
        final id = event.id;

        emit(MovieDetailLoading());

        final result = await usecase.getMovieDetail(id);
        result.fold(
          (error) => emit(MovieDetailError(error.message)),
          (detail) => detail.title.isNotEmpty
              ? emit(MovieDetailLoaded(detail))
              : emit(const MovieDetailNoData("")),
        );
      },
    );
  }
}
