import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final DetailUsecase usecase;
  TvDetailBloc({
    required this.usecase,
  }) : super(TvDetailInitial()) {
    on<GetDetailTv>(
      (event, emit) async {
        final id = event.id;

        emit(TvDetailLoading());

        final result = await usecase.getTvDetail(id);
        result.fold(
          (error) => emit(TvDetailError(error.message)),
          (detail) => detail.title.isNotEmpty
              ? emit(TvDetailLoaded(detail))
              : emit(const TvDetailError("")),
        );
      },
    );
  }
}
