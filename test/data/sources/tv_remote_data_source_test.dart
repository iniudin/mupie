import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:ditonton/data/sources/tv_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helpers.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvRemoteDataSource tvRemoteDataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    tvRemoteDataSource = TvRemoteDataSource(httpClient: mockIOClient);
  });

  group('get Now Playing Tv', () {
    final testTvList =
        TvResponse.fromJson(json.decode(readJson('json/tv/on_air.json')))
            .tvList;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/tv/on_air.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await tvRemoteDataSource.onTheAir();

      expect(result, equals(testTvList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = tvRemoteDataSource.onTheAir();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv', () {
    final testTvList =
        TvResponse.fromJson(json.decode(readJson('json/tv/popular.json')))
            .tvList;

    test('should tvList list of Tv when response is success (200)', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/tv/popular.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await tvRemoteDataSource.getPopular();

      expect(result, testTvList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = tvRemoteDataSource.getPopular();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv', () {
    final testTvList =
        TvResponse.fromJson(json.decode(readJson('json/tv/top_rated.json')))
            .tvList;

    test('should tvList list of Tv when response code is 200 ', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/tv/top_rated.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await tvRemoteDataSource.getTopRated();

      expect(result, testTvList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = tvRemoteDataSource.getTopRated();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    const tId = 453395;
    final testTvDetail =
        TvDetailModel.fromJson(json.decode(readJson('json/tv/detail.json')));

    test('should return tv detail when the response code is 200', () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey'))).thenAnswer(
        (_) async => http.Response(
          readJson('json/tv/detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await tvRemoteDataSource.getDetail(tId);

      expect(result, equals(testTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = tvRemoteDataSource.getDetail(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final testTvList = TvResponse.fromJson(
            json.decode(readJson('json/tv/recommendations.json')))
        .tvList;
    const tId = 453395;

    test('should return list of Tv Model when the response code is 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('json/tv/recommendations.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await tvRemoteDataSource.getRecommendations(tId);

      expect(result, equals(testTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = tvRemoteDataSource.getRecommendations(tId);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search Tv', () {
    final tSearchResult =
        TvResponse.fromJson(json.decode(readJson('json/tv/search.json')))
            .tvList;
    const tQuery = 'naruto';

    test('should return list of Tv when response code is 200', () async {
      when(mockIOClient.get(
        Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery'),
      )).thenAnswer(
        (_) async => http.Response(
          readJson('json/tv/search.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );

      final result = await tvRemoteDataSource.search(tQuery);

      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockIOClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      final call = tvRemoteDataSource.search(tQuery);

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
