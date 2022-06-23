import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:equatable/equatable.dart';

part 'movie_recommendation_event.dart';
part 'movie_recommendation_state.dart';

class MovieRecommendationBloc
    extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final DetailUsecase usecase;
  MovieRecommendationBloc({required this.usecase})
      : super(MovieRecommendationInitial()) {
    on<GetMovieRecommendation>((event, emit) async {
      final int id = event.id;

      emit(MovieRecommendationLoading());

      final result = await usecase.getMovieRecommendations(id);
      result.fold(
        (error) => emit(MovieRecommendationError(error.message)),
        (recommendation) => recommendation.isNotEmpty
            ? emit(MovieRecommendationLoaded(recommendation))
            : emit(const MovieRecommendationError(
                'This tv has not have recommendations',
              )),
      );
    });
  }
}
