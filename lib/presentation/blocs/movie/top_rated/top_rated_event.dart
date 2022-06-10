part of 'top_rated_bloc.dart';

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();

  @override
  List<Object> get props => [];
}

class GetTopRated extends MovieTopRatedEvent {
  const GetTopRated();
}
