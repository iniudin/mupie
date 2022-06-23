part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchEmpty extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  const MovieSearchLoaded(this.movies);

  final List<Movie> movies;

  @override
  List<Object> get props => [movies];
}

class MovieSearchError extends MovieSearchState {
  const MovieSearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
