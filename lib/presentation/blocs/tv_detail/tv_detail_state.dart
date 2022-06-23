part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvDetail tvDetail;

  const TvDetailLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class TvDetailError extends TvDetailState {
  final String message;

  const TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailNoData extends TvDetailState {
  final String message;

  const TvDetailNoData(this.message);

  @override
  List<Object> get props => [message];
}
