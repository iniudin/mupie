import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/tv_detail/tv_detail_bloc.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDetailUsecase mockUsecase;
  late TvDetailBloc detailBloc;

  setUp(() {
    mockUsecase = MockDetailUsecase();
    detailBloc = TvDetailBloc(usecase: mockUsecase);
  });
  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getTvDetail(1)).thenAnswer(
        (_) async => const Right(testTvDetail),
      );
      return detailBloc;
    },
    act: (bloc) => bloc.add(const GetDetailTv(1)),
    expect: () => [
      TvDetailLoading(),
      const TvDetailLoaded(testTvDetail),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTvDetail(1));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getTvDetail(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return detailBloc;
    },
    act: (bloc) => bloc.add(const GetDetailTv(1)),
    expect: () => [
      TvDetailLoading(),
      const TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTvDetail(1));
    },
  );
}
