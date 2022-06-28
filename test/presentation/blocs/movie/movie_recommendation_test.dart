import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDetailUsecase mockUsecase;
  late MovieRecommendationBloc movieBloc;

  setUp(() {
    mockUsecase = MockDetailUsecase();
    movieBloc = MovieRecommendationBloc(usecase: mockUsecase);
  });
  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getMovieRecommendations(1)).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendation(1)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.getMovieRecommendations(1));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getMovieRecommendations(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendation(1)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getMovieRecommendations(1));
    },
  );
}
