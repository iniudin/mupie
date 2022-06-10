part of 'on_the_air_bloc.dart';

abstract class TvOnTheAirState extends Equatable {
  const TvOnTheAirState();

  @override
  List<Object> get props => [];
}

class TvOnTheAirInitial extends TvOnTheAirState {}

class TvOnTheAirLoading extends TvOnTheAirState {}

class TvOnTheAirLoaded extends TvOnTheAirState {
  final List<Tv> tvList;

  const TvOnTheAirLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class TvOnTheAirError extends TvOnTheAirState {
  final String message;

  const TvOnTheAirError(this.message);

  @override
  List<Object> get props => [message];
}
