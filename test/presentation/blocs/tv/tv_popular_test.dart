import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/tv_popular/tv_popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockTvUsecase mockUsecase;
  late TvPopularBloc tvBloc;

  setUp(() {
    mockUsecase = MockTvUsecase();
    tvBloc = TvPopularBloc(usecase: mockUsecase);
  });
  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getPopular()).thenAnswer(
        (_) async => Right(testTvList),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.getPopular());
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getPopular()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetPopular()),
    expect: () => [
      TvPopularLoading(),
      const TvPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getPopular());
    },
  );
}
