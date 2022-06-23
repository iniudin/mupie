part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class TvSearchInitial extends TvSearchState {}

class TvSearchEmpty extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchLoaded extends TvSearchState {
  const TvSearchLoaded(this.tvs);

  final List<Tv> tvs;

  @override
  List<Object> get props => [tvs];
}

class TvSearchError extends TvSearchState {
  const TvSearchError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
