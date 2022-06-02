import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';

class WatchlistModel extends Equatable {
  final int? id;
  final String? title;
  final String? overview;
  final String? posterPath;
  final int? isMovie;

  WatchlistModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.isMovie,
  });

  factory WatchlistModel.fromJson(Map<String, dynamic> json) => WatchlistModel(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        posterPath: json["posterPath"],
        isMovie: json["isMovie"],
      );

  factory WatchlistModel.fromMovieEntity(MovieDetail movie) => WatchlistModel(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        isMovie: 1,
      );

  factory WatchlistModel.fromTvEntity(TvDetail tv) => WatchlistModel(
        id: tv.id,
        title: tv.title,
        posterPath: tv.posterPath,
        overview: tv.overview,
        isMovie: 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'isMovie': isMovie,
      };

  Watchlist toEntity() => Watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
        isMovie: isMovie == 1 ? 1 : 0,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        isMovie,
      ];
}
