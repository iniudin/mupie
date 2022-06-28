import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/models/watchlist_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data.dart';

void main() {
  group("MovieModel test", () {
    group("toEntity test", () {
      test('should be a subclass of Movie entity', () async {
        final result = testMovieModel.toEntity();
        expect(result, testMovie);
      });
      test('should be a subclass of MovieDetail entity', () async {
        final result = testMovieDetailModel.toEntity();
        expect(result, testMovieDetail);
      });
    });

    group("fromJson", () {
      test('should return a valid model from JSON', () async {
        final result = MovieResponse.fromJson(testMovieJson);
        expect(result, testMovieResponseModel);
      });
      test('should return a valid model from JSON', () async {
        final result = MovieDetailModel.fromJson(testMovieDetailJson);
        expect(result, testMovieDetailModel);
      });
    });
    group('toJson', () {
      test('should return a JSON map containing proper data', () async {
        final result = testMovieResponseModel.toJson();
        expect(result, testMovieJson);
      });
      test('should return a JSON map containing proper data', () async {
        final result = testMovieDetailModel.toJson();
        expect(result, testMovieDetailJson);
      });
    });
  });

  group("TvModel test", () {
    group("toEntity test", () {
      test('should be a subclass of Tv entity', () async {
        final result = testTvModel.toEntity();
        expect(result, testTv);
      });

      test('should be a subclass of TvDetail entity', () async {
        final result = testTvDetailModel.toEntity();
        expect(result, testTvDetail);
      });
    });

    group("fromJson test", () {
      test('should return a valid model from JSON', () async {
        final result = TvResponse.fromJson(testTvJson);
        expect(result, testTvResponseModel);
      });
      test('should return a valid model from JSON', () async {
        final result = TvDetailModel.fromJson(testTvDetailJson);
        expect(result, testTvDetailModel);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () async {
        final result = testTvResponseModel.toJson();
        const testTvJsonExpected = {
          "results": [
            {
              "backdrop_path": "backdropPath",
              "genre_ids": [1, 2, 3],
              "id": 1,
              "original_title": "originalTitle",
              "overview": "overview",
              "popularity": 1,
              "poster_path": "posterPath",
              "release_date": "releaseDate",
              "title": "title",
              "vote_average": 1,
              "vote_count": 1
            },
          ]
        };
        expect(result, testTvJsonExpected);
      });

      test('should return a JSON map containing proper data', () async {
        final result = testTvDetailModel.toJson();
        const testTvDetailJsonExpected = {
          "adult": false,
          "backdrop_path": "backdropPath",
          "genres": [
            {"id": 1, "name": "name"},
          ],
          "id": 1,
          "original_title": "originalTitle",
          "overview": "overview",
          "poster_path": "posterPath",
          "release_date": "releaseDate",
          "runtime": 1,
          "title": "title",
          "vote_average": 1.0,
          "vote_count": 1
        };
        expect(result, testTvDetailJsonExpected);
      });
    });
  });

  group("Watchlist test", () {
    group("toEntity test", () {
      test('should be a subclass of Watchlist entity', () async {
        final result = testWatchlistModel.toEntity();
        expect(result, testWatchlist);
      });
    });

    group("fromJson test", () {
      test('should return a valid model from JSON', () async {
        final result = WatchlistModel.fromJson(testWatchlistJson);
        expect(result, testWatchlistModel);
      });
    });

    group('toJson', () {
      test('should return a JSON map containing proper data', () async {
        final result = testWatchlistModel.toJson();
        expect(result, testWatchlistJson);
      });
    });
    group('fromEntity', () {
      test('should return a JSON map containing proper data', () async {
        final result = WatchlistModel.fromEntity(testWatchlist);
        expect(result, testWatchlistModel);
      });
    });
  });
}
