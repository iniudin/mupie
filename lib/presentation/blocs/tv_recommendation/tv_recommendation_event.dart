part of 'tv_recommendation_bloc.dart';

abstract class TvRecommendationEvent extends Equatable {
  const TvRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetTvRecommendation extends TvRecommendationEvent {
  final int id;

  const GetTvRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
