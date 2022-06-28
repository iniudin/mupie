import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDetailUsecase mockUsecase;
  late TvRecommendationBloc tvBloc;

  setUp(() {
    mockUsecase = MockDetailUsecase();
    tvBloc = TvRecommendationBloc(usecase: mockUsecase);
  });
  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getTvRecommendations(1)).thenAnswer(
        (_) async => Right(testTvList),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetTvRecommendation(1)),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTvRecommendations(1));
    },
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getTvRecommendations(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetTvRecommendation(1)),
    expect: () => [
      TvRecommendationLoading(),
      const TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTvRecommendations(1));
    },
  );
}
