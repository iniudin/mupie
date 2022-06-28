import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockSearchUsecase mockUsecase;
  late MovieSearchBloc movieBloc;

  setUp(() {
    mockUsecase = MockSearchUsecase();
    movieBloc = MovieSearchBloc(usecase: mockUsecase);
  });

  test("initial state should be empty", () {
    expect(movieBloc.state, MovieSearchEmpty());
  });

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.searchMovie("name")).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const MovieTextChanged(query: "name")),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      MovieSearchLoading(),
      MovieSearchLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockUsecase.searchMovie("name"));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.searchMovie("name")).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return movieBloc;
    },
    act: (bloc) => bloc.add(const MovieTextChanged(query: "name")),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      MovieSearchLoading(),
      const MovieSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.searchMovie("name"));
    },
  );
}
