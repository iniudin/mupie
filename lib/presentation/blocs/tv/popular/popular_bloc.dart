import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final TvUsecase usecase;

  TvPopularBloc({required this.usecase}) : super(TvPopularInitial()) {
    on<GetPopular>((event, emit) async {
      emit(TvPopularLoading());

      final result = await usecase.getPopular();
      result.fold(
        (error) => emit(TvPopularError(error.message)),
        (tv) => tv.isNotEmpty
            ? emit(TvPopularLoaded(tv))
            : emit(const TvPopularError('Failed')),
      );
    });
  }
}
