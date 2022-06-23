part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetWatchlist extends WatchlistEvent {
  const GetWatchlist();
}

class AddWatchlist extends WatchlistEvent {
  final Watchlist watchlist;

  const AddWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class IsWatchlist extends WatchlistEvent {
  final Watchlist watchlist;

  const IsWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class RemoveWatchlist extends WatchlistEvent {
  final Watchlist watchlist;

  const RemoveWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}
