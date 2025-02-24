part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailMovie extends MovieDetailEvent {
  final int id;

  const GetDetailMovie(this.id);

  @override
  List<Object> get props => [id];
}
