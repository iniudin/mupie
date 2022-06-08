import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, int>> save(Watchlist watchlist);
  Future<Either<Failure, int>> remove(Watchlist watchlist);
  Future<Either<Failure, bool>> isWatchlisted(int id, int isMovie);
  Future<Either<Failure, List<Watchlist>>> getWatchlists();
}
