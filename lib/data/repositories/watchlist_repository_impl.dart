import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/watchlist_model.dart';
import 'package:ditonton/data/sources/watchlist_local_data_source.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlists() async {
    try {
      final result = await localDataSource.getAllWatchlist();
      return Right(result.map((model) => model.toEntity()).toList());
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> remove(Watchlist watchlist) async {
    try {
      await localDataSource
          .removeWatchlist(WatchlistModel.fromEntity(watchlist));
      return const Right('Removed from Watchlist');
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> save(Watchlist watchlist) async {
    try {
      await localDataSource
          .insertWatchlist(WatchlistModel.fromEntity(watchlist));
      return const Right('Added to Watchlist');
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isWatchlisted(int id, int isMovie) async {
    try {
      final result = await localDataSource.getWatchlistById(id, isMovie);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
