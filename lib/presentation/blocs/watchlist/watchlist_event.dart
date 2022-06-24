part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class GetList extends WatchlistEvent {
  const GetList();
}

class AddWatchlist extends WatchlistEvent {
  final Watchlist watchlist;

  const AddWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class StatusWatchlist extends WatchlistEvent {
  final int id;
  final int isMovie;

  const StatusWatchlist(this.id, this.isMovie);

  @override
  List<Object> get props => [id, isMovie];
}

class RemoveWatchlist extends WatchlistEvent {
  final Watchlist watchlist;

  const RemoveWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}
