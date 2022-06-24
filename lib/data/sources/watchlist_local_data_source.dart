import 'package:ditonton/data/models/watchlist_model.dart';
import 'package:ditonton/data/services/database_service.dart';

abstract class WatchlistLocalDataSource {
  Future<int> insertWatchlist(WatchlistModel watchlistModel);
  Future<int> removeWatchlist(WatchlistModel watchlistModel);
  Future<bool> getWatchlistById(int id, int isMovie);
  Future<List<WatchlistModel>> getAllWatchlist();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseService databaseService;

  WatchlistLocalDataSourceImpl(this.databaseService);

  @override
  Future<List<WatchlistModel>> getAllWatchlist() async {
    return await databaseService.findAll();
  }

  @override
  Future<bool> getWatchlistById(int id, int isMovie) async {
    return await databaseService.findById(id, isMovie);
  }

  @override
  Future<int> insertWatchlist(WatchlistModel watchlistModel) async {
    return await databaseService.insert(watchlistModel);
  }

  @override
  Future<int> removeWatchlist(WatchlistModel watchlistModel) async {
    return await databaseService.remove(watchlistModel);
  }
}
