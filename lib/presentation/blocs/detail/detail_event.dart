part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetail extends DetailEvent {
  final int id;
  const GetMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class GetTvDetail extends DetailEvent {
  final int id;

  const GetTvDetail(this.id);

  @override
  List<Object> get props => [id];
}

class GetMovieRecommendations extends DetailEvent {
  final int id;
  const GetMovieRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class GetTvRecommendations extends DetailEvent {
  final int id;
  const GetTvRecommendations(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends DetailEvent {
  final Watchlist watchlist;

  const AddWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class IsWatchlisted extends DetailEvent {
  final Watchlist watchlist;

  const IsWatchlisted(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class RemoveWatchlist extends DetailEvent {
  final Watchlist watchlist;

  const RemoveWatchlist(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}
