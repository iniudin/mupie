import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late DetailUsecase usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    mockWatchlistRepository = MockWatchlistRepository();

    usecase = DetailUsecase(
      movieRepository: mockMovieRepository,
      tvRepository: mockTvRepository,
      watchlistRepository: mockWatchlistRepository,
    );
  });

  const tId = 1;
  const tIsMovie = 1;

  test('movie detail', () async {
    // arrange
    when(mockMovieRepository.getDetail(tId))
        .thenAnswer((_) async => const Right(testMovieDetail));
    // act
    final result = await usecase.getMovieDetail(tId);
    // assert
    expect(result, const Right(testMovieDetail));
  });

  test('movie recommendations', () async {
    // arrange
    when(mockMovieRepository.getRecommendations(tId))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getMovieRecommendations(tId);
    // assert
    expect(result, Right(testMovieList));
  });
  test('tv detail', () async {
    // arrange
    when(mockTvRepository.getDetail(tId))
        .thenAnswer((_) async => const Right(testTvDetail));
    // act
    final result = await usecase.getTvDetail(tId);
    // assert
    expect(result, const Right(testTvDetail));
  });

  test('tv recommendations', () async {
    // arrange
    when(mockTvRepository.getRecommendations(tId))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.getTvRecommendations(tId);
    // assert
    expect(result, Right(testTvList));
  });
  test('is watchlist', () async {
    // arrange
    when(mockWatchlistRepository.isWatchlisted(tId, tIsMovie))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await usecase.isWatchlisted(tId, tIsMovie);
    // assert
    expect(result, const Right(true));
  });
  test('save watchlist', () async {
    // arrange
    when(mockWatchlistRepository.save(testWatchlist))
        .thenAnswer((_) async => const Right("Added to Watchlist"));
    // act
    final result = await usecase.save(testWatchlist);
    // assert
    expect(result, const Right("Added to Watchlist"));
  });
  test('remove watchlist', () async {
    // arrange
    when(mockWatchlistRepository.remove(testWatchlist))
        .thenAnswer((_) async => const Right("Removed from Watchlist"));
    // act
    final result = await usecase.remove(testWatchlist);
    // assert
    expect(result, const Right("Removed from Watchlist"));
  });
}
