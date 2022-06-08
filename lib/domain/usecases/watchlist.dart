import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class WatchlistUsecase {
  final WatchlistRepository watchlistRepository;

  WatchlistUsecase(this.watchlistRepository);

  Future<Either<Failure, List<Watchlist>>> getWatchlists() {
    return watchlistRepository.getWatchlists();
  }
}
