part of 'popular_bloc.dart';

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();

  @override
  List<Object> get props => [];
}

class GetPopular extends MoviePopularEvent {
  const GetPopular();
}
