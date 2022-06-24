import 'package:ditonton/data/models/watchlist_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;

  DatabaseService._internal() {
    _instance = this;
  }

  factory DatabaseService() => _instance ?? DatabaseService._internal();

  final String tableName = 'watchList';

  Future<Database?> get database async => _database ??= await _initializeDb();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();

    var db = openDatabase(
      '$path/database.db',
      onCreate: _onCreate,
      version: 1,
    );

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $tableName (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        isMovie INTEGER
      );
    ''');
  }

  Future<int> insert(WatchlistModel watchlistModel) async {
    final db = await database;
    return await db!.insert(tableName, watchlistModel.toJson());
  }

  Future<List<WatchlistModel>> findAll() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(tableName);

    return results.map((res) => WatchlistModel.fromJson(res)).toList();
  }

  Future<bool> findById(int id, int isMovie) async {
    final db = await database;

    final result = await db!.query(
      tableName,
      where: 'id = ? and isMovie = ?',
      whereArgs: [id, isMovie],
    );

    return result.isNotEmpty;
  }

  Future<int> remove(WatchlistModel watchlistModel) async {
    final db = await database;

    return await db!.delete(
      tableName,
      where: 'id = ? and isMovie = ?',
      whereArgs: [watchlistModel.id, watchlistModel.isMovie],
    );
  }
}
