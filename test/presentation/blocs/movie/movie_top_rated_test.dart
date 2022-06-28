import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockMovieUsecase mockUsecase;
  late MovieTopRatedBloc movieBloc;

  setUp(() {
    mockUsecase = MockMovieUsecase();
    movieBloc = MovieTopRatedBloc(usecase: mockUsecase);
  });
  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getTopRated()).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const GetMovieTopRated()),
    expect: () => [
      MovieTopRatedLoading(),
      MovieTopRatedLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTopRated());
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getTopRated()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const GetMovieTopRated()),
    expect: () => [
      MovieTopRatedLoading(),
      const MovieTopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getTopRated());
    },
  );
}
