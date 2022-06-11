part of 'on_playing_bloc.dart';

abstract class MovieOnPlayingEvent extends Equatable {
  const MovieOnPlayingEvent();

  @override
  List<Object> get props => [];
}

class GetMovieNowPlaying extends MovieOnPlayingEvent {
  const GetMovieNowPlaying();
}
