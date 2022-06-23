import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:ditonton/domain/usecases/watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final DetailUsecase detailUsecase;
  final WatchlistUsecase watchlistUsecase;

  WatchlistBloc({
    required this.detailUsecase,
    required this.watchlistUsecase,
  }) : super(WatchlistInitial()) {
    on<GetWatchlist>((event, emit) async {
      emit(WatchlistLoading());

      final result = await watchlistUsecase.getWatchlists();
      result.fold(
        (error) => emit(WatchlistError(error.message)),
        (watchlist) => watchlist.isNotEmpty
            ? emit(WatchlistLoaded(watchlist))
            : emit(const WatchlistNoData('')),
      );
    });

    on<AddWatchlist>((event, emit) async {
      final watchlist = event.watchlist;

      emit(
        WatchlistLoading(),
      );

      final result = await detailUsecase.save(watchlist);
      result.fold(
        (error) => emit(
          WatchlistError(error.message),
        ),
        (success) => add(IsWatchlist(watchlist)),
      );
    });

    on<RemoveWatchlist>((event, emit) async {
      final watchlist = event.watchlist;

      emit(
        WatchlistLoading(),
      );

      final result = await detailUsecase.remove(watchlist);
      result.fold(
        (error) => emit(
          WatchlistError(error.message),
        ),
        (success) => add(IsWatchlist(watchlist)),
      );
    });

    on<IsWatchlist>((event, emit) async {
      final id = event.watchlist.id;
      final isMovie = event.watchlist.isMovie;

      emit(
        WatchlistLoading(),
      );

      final result = await detailUsecase.isWatchlisted(id, isMovie);
      result.fold(
        (error) => emit(WatchlistError(error.message)),
        (success) => emit(WatchlistListed(success)),
      );
    });
  }
}
