import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockDetailUsecase mockDetailUsecase;
  late MockWatchlistUsecase mockWatchlistUsecase;
  late WatchlistBloc watchlistBloc;

  setUp(() {
    mockDetailUsecase = MockDetailUsecase();
    mockWatchlistUsecase = MockWatchlistUsecase();
    watchlistBloc = WatchlistBloc(
      detailUsecase: mockDetailUsecase,
      watchlistUsecase: mockWatchlistUsecase,
    );
  });

  test("initial state should be empty", () {
    expect(watchlistBloc.state, WatchlistInitial());
  });

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockWatchlistUsecase.getWatchlists()).thenAnswer(
        (_) async => const Right([testWatchlist]),
      );
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const GetList()),
    expect: () => [
      WatchlistLoading(),
      const WatchlistLoaded([testWatchlist])
    ],
    verify: (bloc) {
      verify(mockWatchlistUsecase.getWatchlists());
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockWatchlistUsecase.getWatchlists())
          .thenAnswer((_) async => const Left(ServerFailure("Can't get data")));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const GetList()),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError("Can't get data"),
    ],
    verify: (bloc) {
      verify(mockWatchlistUsecase.getWatchlists());
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loaded] when get status watchlist is successful',
    build: () {
      when(mockDetailUsecase.isWatchlisted(1, 1))
          .thenAnswer((_) async => const Right(true));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const StatusWatchlist(1, 1)),
    expect: () => [
      WatchlistLoading(),
      const WatchlistStatusLoaded(true),
    ],
    verify: (bloc) {
      verify(mockDetailUsecase.isWatchlisted(1, 1));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [success] when add item to watchlist is successful',
    build: () {
      when(mockDetailUsecase.save(testWatchlist))
          .thenAnswer((_) async => const Right("Success"));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const AddWatchlist(testWatchlist)),
    expect: () => [
      WatchlistLoading(),
      const WatchlistSuccess("Success"),
    ],
    verify: (bloc) {
      verify(mockDetailUsecase.save(testWatchlist));
    },
  );
  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [error] when add item to watchlist is unsuccessful',
    build: () {
      when(mockDetailUsecase.save(testWatchlist))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const AddWatchlist(testWatchlist)),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError("Failed"),
    ],
    verify: (bloc) {
      verify(mockDetailUsecase.save(testWatchlist));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [success] when remove item to watchlist is successful',
    build: () {
      when(mockDetailUsecase.remove(testWatchlist))
          .thenAnswer((_) async => const Right("Removed"));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const RemoveWatchlist(testWatchlist)),
    expect: () => [
      WatchlistLoading(),
      const WatchlistSuccess("Removed"),
    ],
    verify: (bloc) {
      verify(mockDetailUsecase.remove(testWatchlist));
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [error] when remove item to watchlist is unsuccessful',
    build: () {
      when(mockDetailUsecase.remove(testWatchlist))
          .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(const RemoveWatchlist(testWatchlist)),
    expect: () => [
      WatchlistLoading(),
      const WatchlistError("Failed"),
    ],
    verify: (bloc) {
      verify(mockDetailUsecase.remove(testWatchlist));
    },
  );
}
