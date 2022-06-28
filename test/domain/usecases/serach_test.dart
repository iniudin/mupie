import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchUsecase usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = SearchUsecase(
      movieRepository: mockMovieRepository,
      tvRepository: mockTvRepository,
    );
  });
  const tQuery = "naruto";
  test('movie search', () async {
    // arrange
    when(mockMovieRepository.search(tQuery))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.searchMovie(tQuery);
    // assert
    expect(result, Right(testMovieList));
  });
  test('tv search', () async {
    // arrange
    when(mockTvRepository.search(tQuery))
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.searchTv(tQuery);
    // assert
    expect(result, Right(testTvList));
  });
}
