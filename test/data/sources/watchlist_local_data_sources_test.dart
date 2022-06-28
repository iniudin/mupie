import 'package:ditonton/data/sources/watchlist_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late WatchlistLocalDataSourceImpl dataSource;
  late MockDatabaseService mockDatabaseService;

  setUp(() {
    mockDatabaseService = MockDatabaseService();
    dataSource = WatchlistLocalDataSourceImpl(mockDatabaseService);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseService.insert(testWatchlistModel))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testWatchlistModel);
      // assert
      expect(result, 1);
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseService.insert(testWatchlistModel))
          .thenAnswer((_) async => 0);
      // act
      final result = await dataSource.insertWatchlist(testWatchlistModel);
      // assert
      expect(result, 0);
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseService.remove(testWatchlistModel))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testWatchlistModel);
      // assert
      expect(result, 1);
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseService.remove(testWatchlistModel))
          .thenAnswer((_) async => 0);
      // act
      final result = await dataSource.removeWatchlist(testWatchlistModel);
      // assert
      expect(result, 0);
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;
    const tIsMovie = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseService.findById(tId, tIsMovie))
          .thenAnswer((_) async => true);
      // act
      final result = await dataSource.getWatchlistById(tId, tIsMovie);
      // assert
      expect(result, true);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseService.findById(tId, tIsMovie))
          .thenAnswer((_) async => false);
      // act
      final result = await dataSource.getWatchlistById(tId, tIsMovie);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseService.findAll())
          .thenAnswer((_) async => [testWatchlistModel]);
      // act
      final result = await dataSource.getAllWatchlist();
      // assert
      expect(result, [testWatchlistModel]);
    });
  });
}
