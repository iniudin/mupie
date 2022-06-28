import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockTvUsecase mockTvUsecase;
  late TvOnTheAirBloc tvBloc;

  setUp(() {
    mockTvUsecase = MockTvUsecase();
    tvBloc = TvOnTheAirBloc(usecase: mockTvUsecase);
  });
  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockTvUsecase.onTheAir()).thenAnswer(
        (_) async => Right(testTvList),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      TvOnTheAirLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockTvUsecase.onTheAir());
    },
  );

  blocTest<TvOnTheAirBloc, TvOnTheAirState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockTvUsecase.onTheAir()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvBloc;
    },
    act: (bloc) => bloc.add(const GetOnTheAir()),
    expect: () => [
      TvOnTheAirLoading(),
      const TvOnTheAirError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockTvUsecase.onTheAir());
    },
  );
}
