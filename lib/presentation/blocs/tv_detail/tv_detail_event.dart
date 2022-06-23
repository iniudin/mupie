part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTv extends TvDetailEvent {
  final int id;

  const GetDetailTv(this.id);

  @override
  List<Object> get props => [id];
}
