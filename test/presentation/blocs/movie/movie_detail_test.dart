import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDetailUsecase mockUsecase;
  late MovieDetailBloc detailBloc;

  setUp(() {
    mockUsecase = MockDetailUsecase();
    detailBloc = MovieDetailBloc(usecase: mockUsecase);
  });
  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getMovieDetail(1)).thenAnswer(
        (_) async => const Right(testMovieDetail),
      );
      return detailBloc;
    },
    act: (bloc) => bloc.add(const GetDetailMovie(1)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailLoaded(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockUsecase.getMovieDetail(1));
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getMovieDetail(1)).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return detailBloc;
    },
    act: (bloc) => bloc.add(const GetDetailMovie(1)),
    expect: () => [
      MovieDetailLoading(),
      const MovieDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getMovieDetail(1));
    },
  );
}
