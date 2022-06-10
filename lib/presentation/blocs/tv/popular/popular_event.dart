part of 'popular_bloc.dart';

abstract class TvPopularEvent extends Equatable {
  const TvPopularEvent();

  @override
  List<Object> get props => [];
}

class GetPopular extends TvPopularEvent {
  const GetPopular();
}
