import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/data/sources/movie_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late MovieRemoteDataSource movieRemoteDataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    movieRemoteDataSource = MovieRemoteDataSource(httpClient: mockIOClient);
  });

  group('get Now Playing Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('json/movie/now_playing.json')))
        .movieList;

    test('should return list of Movie Model when the response code is 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/movie/now_playing.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await movieRemoteDataSource.getNowPlaying();

      expect(result, equals(tMovieList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = movieRemoteDataSource.getNowPlaying();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Movies', () {
    final tMovieList =
        MovieResponse.fromJson(json.decode(readJson('json/movie/popular.json')))
            .movieList;

    test('should return list of movies when response is success (200)',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/movie/popular.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await movieRemoteDataSource.getPopular();

      expect(result, tMovieList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = movieRemoteDataSource.getPopular();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Movies', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('json/movie/top_rated.json')))
        .movieList;

    test('should return list of movies when response code is 200 ', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/movie/top_rated.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await movieRemoteDataSource.getTopRated();

      expect(result, tMovieList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = movieRemoteDataSource.getTopRated();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie detail', () {
    const tId = 453395;
    final tMovieDetail = MovieDetailModel.fromJson(
        json.decode(readJson('json/movie/detail.json')));

    test('should return movie detail when the response code is 200', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/$tId?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/movie/detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await movieRemoteDataSource.getDetail(tId);

      expect(result, equals(tMovieDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/movie/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = movieRemoteDataSource.getDetail(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get movie recommendations', () {
    final tMovieList = MovieResponse.fromJson(
            json.decode(readJson('json/movie/recommendations.json')))
        .movieList;
    const tId = 453395;

    test('should return list of Movie Model when the response code is 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/movie/recommendations.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await movieRemoteDataSource.getRecommendations(tId);

      expect(result, equals(tMovieList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/movie/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = movieRemoteDataSource.getRecommendations(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult =
        MovieResponse.fromJson(json.decode(readJson('json/movie/search.json')))
            .movieList;
    const tQuery = 'naruto';

    test('should return list of movies when response code is 200', () async {
      when(mockIOClient.get(
        Uri.parse('$baseUrl/search/movie?$apiKey&query=$tQuery'),
      )).thenAnswer(
        (_) async => http.Response(
          readJson('json/movie/search.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await movieRemoteDataSource.search(tQuery);

      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/movie?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = movieRemoteDataSource.search(tQuery);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
