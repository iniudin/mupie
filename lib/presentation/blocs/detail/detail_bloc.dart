import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailUsecase usecase;
  DetailBloc({required this.usecase}) : super(DetailInitial()) {
    on<GetMovieDetail>((event, emit) async {
      final id = event.id;

      emit(DetailLoading());

      final result = await usecase.getMovieDetail(id);
      result.fold(
          (error) => emit(DetailError(error.message)),
          (detail) => detail.title.isNotEmpty
              ? emit(MovieDetailLoaded(detail))
              : emit(const DetailNodata('Favorite empty.')));
    });

    on<GetMovieRecommendations>((event, emit) async {
      final id = event.id;

      emit(DetailLoading());

      final result = await usecase.getMovieRecommendations(id);
      result.fold(
          (error) => emit(DetailError(error.message)),
          (recommendations) => recommendations.isNotEmpty
              ? emit(MovieRecommendationsLoaded(recommendations))
              : emit(const DetailNodata('Favorite empty.')));
    });

    on<GetTvDetail>((event, emit) async {
      final id = event.id;

      emit(DetailLoading());

      final result = await usecase.getTvDetail(id);
      result.fold(
          (error) => emit(DetailError(error.message)),
          (detail) => detail.title.isNotEmpty
              ? emit(TvDetailLoaded(detail))
              : emit(const DetailNodata('Favorite empty.')));
    });

    on<GetTvRecommendations>((event, emit) async {
      final id = event.id;
      emit(DetailLoading());
      final result = await usecase.getTvRecommendations(id);
      result.fold(
          (error) => emit(DetailError(error.message)),
          (recommendations) => recommendations.isNotEmpty
              ? emit(TvRecommendationsLoaded(recommendations))
              : emit(const DetailNodata('Favorite empty.')));
    });

    on<AddWatchlist>((event, emit) async {
      final watchlist = event.watchlist;

      emit(DetailLoading());

      final result = await usecase.save(watchlist);
      result.fold(
        (error) => emit(DetailError(error.message)),
        (success) => add(IsWatchlisted(watchlist)),
      );
    });

    on<RemoveWatchlist>((event, emit) async {
      final watchlist = event.watchlist;

      emit(DetailLoading());

      final result = await usecase.remove(watchlist);
      result.fold(
        (error) => emit(DetailError(error.message)),
        (success) => add(IsWatchlisted(watchlist)),
      );
    });

    on<IsWatchlisted>((event, emit) async {
      final watchlist = event.watchlist;

      emit(DetailLoading());

      final result =
          await usecase.isWatchlisted(watchlist.id, watchlist.isMovie);
      result.fold(
        (error) => emit(DetailError(error.message)),
        (success) => emit(DetailIsWatchlisted(success)),
      );
    });
  }
}
