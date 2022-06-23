part of 'movie_search_bloc.dart';

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MovieSetEmpty extends MovieSearchEvent {}

class MovieTextChanged extends MovieSearchEvent {
  final String query;

  const MovieTextChanged({required this.query});

  @override
  List<Object> get props => [query];
}
