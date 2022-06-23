import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv.dart';
import 'package:equatable/equatable.dart';

part 'tv_on_the_air_event.dart';
part 'tv_on_the_air_state.dart';

class TvOnTheAirBloc extends Bloc<TvOnTheAirEvent, TvOnTheAirState> {
  final TvUsecase usecase;

  TvOnTheAirBloc({required this.usecase}) : super(TvOnTheAirInitial()) {
    on<GetOnTheAir>((event, emit) async {
      emit(TvOnTheAirLoading());

      final result = await usecase.onTheAir();
      result.fold(
        (error) => emit(TvOnTheAirError(error.message)),
        (tv) => tv.isNotEmpty
            ? emit(TvOnTheAirLoaded(tv))
            : emit(const TvOnTheAirError('Failed')),
      );
    });
  }
}
