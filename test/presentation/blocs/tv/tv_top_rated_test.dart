import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockTvUsecase mockUsecase;
  late TvTopRatedBloc tvBloc;

  setUp(() {
    mockUsecase = MockTvUsecase();
    tvBloc = TvTopRatedBloc(usecase: mockUsecase);
  });
  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getTopRated()).thenAnswer(
        (_) async => Right(testTvList),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetTopRated()),
    expect: () => [
      TvTopRatedLoading(),
      TvTopRatedLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTopRated());
    },
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getTopRated()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetTopRated()),
    expect: () => [
      TvTopRatedLoading(),
      const TvTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTopRated());
    },
  );
}
