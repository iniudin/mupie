import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/movie_popular/popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockMovieUsecase mockUsecase;
  late MoviePopularBloc movieBloc;

  setUp(() {
    mockUsecase = MockMovieUsecase();
    movieBloc = MoviePopularBloc(usecase: mockUsecase);
  });
  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.getPopular()).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const GetMoviePopular()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.getPopular());
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.getPopular()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const GetMoviePopular()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.getPopular());
    },
  );
}
