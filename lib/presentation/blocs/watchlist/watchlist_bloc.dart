import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/watchlist.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class MovieBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistUsecase usecase;
  MovieBloc({required this.usecase}) : super(WatchlistInitial()) {
    on<GetWatchlist>((event, emit) async {
      emit(WatchlistLoading());

      final result = await usecase.getWatchlists();
      result.fold(
        (error) => emit(WatchlistError(error.message)),
        (watchlist) => watchlist.isNotEmpty
            ? emit(WatchlistLoaded(watchlist))
            : emit(const WatchlistNoData('')),
      );
    });
  }
}
