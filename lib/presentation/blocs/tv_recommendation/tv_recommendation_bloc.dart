import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:equatable/equatable.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final DetailUsecase usecase;
  TvRecommendationBloc({required this.usecase})
      : super(TvRecommendationInitial()) {
    on<GetTvRecommendation>((event, emit) async {
      final int id = event.id;

      emit(TvRecommendationLoading());

      final result = await usecase.getTvRecommendations(id);
      result.fold(
        (error) => emit(TvRecommendationError(error.message)),
        (recommentaion) => recommentaion.isNotEmpty
            ? emit(TvRecommendationLoaded(recommentaion))
            : emit(const TvRecommendationError(
                'This movie has not have recommendations',
              )),
      );
    });
  }
}
