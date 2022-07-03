import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:stream_transform/stream_transform.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

const _duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchUsecase usecase;
  TvSearchBloc({required this.usecase}) : super(TvSearchEmpty()) {
    on<TvTextChanged>(_onTextChanged, transformer: debounce(_duration));
  }

  void _onTextChanged(
    TvTextChanged event,
    Emitter<TvSearchState> emit,
  ) async {
    final searchTerm = event.query;

    if (searchTerm.isEmpty) return emit(TvSearchEmpty());

    emit(TvSearchLoading());

    final result = await usecase.searchTv(searchTerm);

    result.fold(
        (error) => emit(TvSearchError(error.message)),
        (result) => result.isNotEmpty
            ? emit(TvSearchLoaded(result))
            : emit(const TvSearchError('No Data')));
  }
}
