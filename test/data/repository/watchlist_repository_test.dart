import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late WatchlistRepository repository;
  late MockWatchlistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(
      localDataSource: mockLocalDataSource,
    );
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testWatchlistModel))
          .thenAnswer((_) async => 1);
      // act
      final result = await repository.save(testWatchlist);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testWatchlistModel))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.save(testWatchlist);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testWatchlistModel))
          .thenAnswer((_) async => 1);
      // act
      final result = await repository.remove(testWatchlist);
      // assert
      expect(result, const Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testWatchlistModel))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.remove(testWatchlist);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      const tIsMovie = 1;
      when(mockLocalDataSource.getWatchlistById(tId, tIsMovie))
          .thenAnswer((_) async => true);
      // act
      final result = await repository.isWatchlisted(tId, tIsMovie);
      // assert
      expect(result, const Right(true));
    });
  });

  group('get watchlist movies', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockLocalDataSource.getAllWatchlist())
          .thenAnswer((_) async => [testWatchlistModel]);
      // act
      final result = await repository.getWatchlists();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlist]);
    });
  });
}
