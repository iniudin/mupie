import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late WatchlistUsecase usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();

    usecase = WatchlistUsecase(mockWatchlistRepository);
  });

  test('tv on air', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlists())
        .thenAnswer((_) async => const Right([testWatchlist]));
    // act
    final result = await usecase.getWatchlists();
    // assert
    expect(result, const Right([testWatchlist]));
  });
}
