part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object> get props => [];
}

class TvSetEmpty extends TvSearchEvent {}

class TvTextChanged extends TvSearchEvent {
  final String query;

  const TvTextChanged({required this.query});

  @override
  List<Object> get props => [query];
}
