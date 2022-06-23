import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchUsecase usecase;
  MovieSearchBloc({required this.usecase}) : super(MovieSearchEmpty()) {
    on<MovieTextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  void _onTextChanged(
    MovieTextChanged event,
    Emitter<MovieSearchState> emit,
  ) async {
    final searchTerm = event.query;

    if (searchTerm.isEmpty) return emit(MovieSearchEmpty());

    emit(MovieSearchLoading());

    final result = await usecase.searchMovie(searchTerm);

    result.fold(
        (error) => emit(MovieSearchError(error.message)),
        (result) => result.isNotEmpty
            ? emit(MovieSearchLoaded(result))
            : emit(const MovieSearchError('No Data')));
  }
}
