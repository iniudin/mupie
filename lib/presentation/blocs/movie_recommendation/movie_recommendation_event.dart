part of 'movie_recommendation_bloc.dart';

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecommendation extends MovieRecommendationEvent {
  final int id;

  const GetMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];

  add(GetMovieRecommendation getMovieRecommendation) {}
}
