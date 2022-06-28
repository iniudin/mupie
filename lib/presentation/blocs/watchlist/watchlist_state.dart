part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Watchlist> watchlist;

  const WatchlistLoaded(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class WatchlistStatusLoaded extends WatchlistState {
  final bool status;

  const WatchlistStatusLoaded(this.status);

  @override
  List<Object> get props => [status];
}

class WatchlistNoData extends WatchlistState {
  final String message;

  const WatchlistNoData(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSuccess extends WatchlistState {
  final String message;

  const WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}
