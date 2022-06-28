import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/watchlist_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

const testMovieJson = {
  "results": [
    {
      "adult": false,
      "backdrop_path": "backdropPath",
      "genre_ids": [1, 2, 3],
      "id": 1,
      "original_title": "originalTitle",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "release_date": "releaseDate",
      "title": "title",
      "video": false,
      "vote_average": 1,
      "vote_count": 1
    },
  ]
};

const testMovieDetailJson = {
  "adult": false,
  "backdrop_path": "backdropPath",
  "budget": 1,
  "genres": [
    {"id": 1, "name": "name"},
  ],
  "homepage": "homepage",
  "id": 1,
  "imdb_id": "imdbId",
  "original_language": "originalLanguage",
  "original_title": "originalTitle",
  "overview": "overview",
  "popularity": 1,
  "poster_path": "posterPath",
  "release_date": "releaseDate",
  "revenue": 1,
  "runtime": 1,
  "status": "status",
  "tagline": "tagline",
  "title": "title",
  "video": false,
  "vote_average": 1,
  "vote_count": 1,
};

const testTvJson = {
  "results": [
    {
      "backdrop_path": "backdropPath",
      "genre_ids": [1, 2, 3],
      "id": 1,
      "original_name": "originalTitle",
      "overview": "overview",
      "popularity": 1,
      "poster_path": "posterPath",
      "first_air_date": "releaseDate",
      "name": "title",
      "video": false,
      "vote_average": 1,
      "vote_count": 1
    },
  ]
};

const testTvDetailJson = {
  "adult": false,
  "backdrop_path": "backdropPath",
  "genres": [
    {"id": 1, "name": "name"},
  ],
  "id": 1,
  "original_name": "originalTitle",
  "overview": "overview",
  "poster_path": "posterPath",
  "first_air_date": "releaseDate",
  "episode_run_time": [1],
  "name": "title",
  "vote_average": 1,
  "vote_count": 1
};
const testGenreModel = GenreModel(id: 1, name: "name");
const testGenre = Genre(id: 1, name: "name");

const testMovieModel = MovieModel(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

const testMovie = Movie(
  adult: false,
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

const testMovieDetailModel = MovieDetailModel(
  adult: false,
  backdropPath: "backdropPath",
  budget: 1,
  genres: [testGenreModel],
  homepage: "homepage",
  id: 1,
  imdbId: "imdbId",
  originalLanguage: "originalLanguage",
  originalTitle: "originalTitle",
  overview: "overview",
  popularity: 1,
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  revenue: 1,
  runtime: 1,
  status: "status",
  tagline: "tagline",
  title: "title",
  video: false,
  voteAverage: 1,
  voteCount: 1,
);

const testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: "backdropPath",
  genres: [testGenre],
  id: 1,
  originalTitle: "originalTitle",
  overview: "overview",
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  runtime: 1,
  title: "title",
  voteAverage: 1,
  voteCount: 1,
);

const testTvModel = TvModel(
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testTv = Tv(
  backdropPath: 'backdropPath',
  genreIds: [1, 2, 3],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

const testTvDetailModel = TvDetailModel(
  adult: false,
  backdropPath: "backdropPath",
  genres: [testGenreModel],
  id: 1,
  originalTitle: "originalTitle",
  overview: "overview",
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  runtime: 1,
  title: "title",
  voteAverage: 1,
  voteCount: 1,
);

const testTvDetail = TvDetail(
  adult: false,
  backdropPath: "backdropPath",
  genres: [testGenre],
  id: 1,
  originalTitle: "originalTitle",
  overview: "overview",
  posterPath: "posterPath",
  releaseDate: "releaseDate",
  runtime: 1,
  title: "title",
  voteAverage: 1,
  voteCount: 1,
);
const testWatchlist = Watchlist(
  id: 1,
  title: "title",
  overview: "overview",
  posterPath: "posterPath",
  isMovie: 1,
);
const testWatchlistModel = WatchlistModel(
  id: 1,
  title: "title",
  overview: "overview",
  posterPath: "posterPath",
  isMovie: 1,
);
const testWatchlistJson = {
  "id": 1,
  "title": "title",
  "posterPath": "posterPath",
  "overview": "overview",
  "isMovie": 1,
};

const testMovieResponseModel =
    MovieResponse(movieList: <MovieModel>[testMovieModel]);
const testTvResponseModel = TvResponse(tvList: <TvModel>[testTvModel]);

final testMovieModelList = <MovieModel>[testMovieModel];
final testMovieList = <Movie>[testMovie];

final testTvModelList = <TvModel>[testTvModel];
final testTvList = <Tv>[testTv];
