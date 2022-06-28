import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MovieUsecase usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();

    usecase = MovieUsecase(mockMovieRepository);
  });

  test('movie now playing', () async {
    // arrange
    when(mockMovieRepository.getNowPlaying())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getNowPlaying();
    // assert
    expect(result, Right(testMovieList));
  });
  test('movie top rated', () async {
    // arrange
    when(mockMovieRepository.getTopRated())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getTopRated();
    // assert
    expect(result, Right(testMovieList));
  });
  test('movie now playing', () async {
    // arrange
    when(mockMovieRepository.getPopular())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase.getPopular();
    // assert
    expect(result, Right(testMovieList));
  });
}
