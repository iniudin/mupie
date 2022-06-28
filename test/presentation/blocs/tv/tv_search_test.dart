import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/tv_search/tv_search_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late MockSearchUsecase mockUsecase;
  late TvSearchBloc tvSearchBloc;

  setUp(() {
    mockUsecase = MockSearchUsecase();
    tvSearchBloc = TvSearchBloc(usecase: mockUsecase);
  });

  test("initial state should be empty", () {
    expect(tvSearchBloc.state, TvSearchEmpty());
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockUsecase.searchTv("name")).thenAnswer(
        (_) async => Right(testTvList),
      );
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const TvTextChanged(query: "name")),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      TvSearchLoading(),
      TvSearchLoaded(testTvList),
    ],
    verify: (bloc) {
      verify(mockUsecase.searchTv("name"));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'Should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockUsecase.searchTv("name")).thenAnswer(
        (_) async => const Left(ServerFailure('Server Failure')),
      );
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(const TvTextChanged(query: "name")),
    wait: const Duration(milliseconds: 300),
    expect: () => [
      TvSearchLoading(),
      const TvSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockUsecase.searchTv("name"));
    },
  );
}
