import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final TvUsecase usecase;

  TvTopRatedBloc({required this.usecase}) : super(TvTopRatedInitial()) {
    on<GetTopRated>((event, emit) async {
      emit(TvTopRatedLoading());

      final result = await usecase.getTopRated();
      result.fold(
        (error) => emit(TvTopRatedError(error.message)),
        (tv) => tv.isNotEmpty
            ? emit(TvTopRatedLoaded(tv))
            : emit(const TvTopRatedError('Failed')),
      );
    });
  }
}
