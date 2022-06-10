part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class MovieDetailLoaded extends DetailState {
  final MovieDetail movieDetail;

  const MovieDetailLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class TvDetailLoaded extends DetailState {
  final TvDetail tvDetail;

  const TvDetailLoaded(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class MovieRecommendationsLoaded extends DetailState {
  final List<Movie> movieList;

  const MovieRecommendationsLoaded(this.movieList);

  @override
  List<Object> get props => [movieList];
}

class TvRecommendationsLoaded extends DetailState {
  final List<Tv> tvList;

  const TvRecommendationsLoaded(this.tvList);

  @override
  List<Object> get props => [tvList];
}

class DetailNodata extends DetailState {
  final String message;

  const DetailNodata(this.message);

  @override
  List<Object> get props => [message];
}

class DetailError extends DetailState {
  final String message;

  const DetailError(this.message);
  @override
  List<Object> get props => [message];
}

class DetailIsWatchlisted extends DetailState {
  final bool isWatchlist;

  const DetailIsWatchlisted(this.isWatchlist);

  @override
  List<Object> get props => [isWatchlist];
}
