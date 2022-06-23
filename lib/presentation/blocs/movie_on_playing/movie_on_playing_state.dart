part of 'movie_on_playing_bloc.dart';

abstract class MovieOnPlayingState extends Equatable {
  const MovieOnPlayingState();

  @override
  List<Object> get props => [];
}

class MovieOnPlayingInitial extends MovieOnPlayingState {}

class MovieOnPlayingLoading extends MovieOnPlayingState {}

class MovieOnPlayingLoaded extends MovieOnPlayingState {
  final List<Movie> movieList;

  const MovieOnPlayingLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class MovieOnPlayingError extends MovieOnPlayingState {
  final String message;

  const MovieOnPlayingError(this.message);

  @override
  List<Object> get props => [message];
}
