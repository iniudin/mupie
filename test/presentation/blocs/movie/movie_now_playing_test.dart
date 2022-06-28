import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/movie_on_playing/movie_on_playing_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockMovieUsecase mockMovieUsecase;
  late MovieOnPlayingBloc movieOnPlayingBloc;

  setUp(() {
    mockMovieUsecase = MockMovieUsecase();
    movieOnPlayingBloc = MovieOnPlayingBloc(usecase: mockMovieUsecase);
  });
  blocTest<MovieOnPlayingBloc, MovieOnPlayingState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockMovieUsecase.getNowPlaying()).thenAnswer(
        (_) async => Right(testMovieList),
      );
      return movieOnPlayingBloc;
    },
    act: (bloc) => bloc.add(const GetMovieNowPlaying()),
    expect: () => [
      MovieOnPlayingLoading(),
      MovieOnPlayingLoaded(testMovieList),
    ],
    verify: (bloc) {
      verify(mockMovieUsecase.getNowPlaying());
    },
  );

  blocTest<MovieOnPlayingBloc, MovieOnPlayingState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockMovieUsecase.getNowPlaying()).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return movieOnPlayingBloc;
    },
    act: (bloc) => bloc.add(const GetMovieNowPlaying()),
    expect: () => [
      MovieOnPlayingLoading(),
      const MovieOnPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockMovieUsecase.getNowPlaying());
    },
  );
}
