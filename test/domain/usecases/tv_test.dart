import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TvUsecase usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();

    usecase = TvUsecase(mockTvRepository);
  });

  test('tv on air', () async {
    // arrange
    when(mockTvRepository.onTheAir())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.onTheAir();
    // assert
    expect(result, Right(testTvList));
  });
  test('tv top rated', () async {
    // arrange
    when(mockTvRepository.getTopRated())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.getTopRated();
    // assert
    expect(result, Right(testTvList));
  });
  test('tv now playing', () async {
    // arrange
    when(mockTvRepository.getPopular())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.getPopular();
    // assert
    expect(result, Right(testTvList));
  });
}
