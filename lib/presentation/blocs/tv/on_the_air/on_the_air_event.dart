part of 'on_the_air_bloc.dart';

abstract class TvOnTheAirEvent extends Equatable {
  const TvOnTheAirEvent();

  @override
  List<Object> get props => [];
}

class GetOnTheAir extends TvOnTheAirEvent {
  const GetOnTheAir();
}
