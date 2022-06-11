import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:http/http.dart' as http;

class TvService {
  static const _apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const _baseUrl = 'https://api.themoviedb.org/3';

  final http.Client _client;

  TvService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<TvModel>> onTheAir() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/tv/on_the_air?$_apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  Future<TvDetailResponse> getDetail(int id) async {
    final response = await _client.get(Uri.parse('$_baseUrl/tv/$id?$_apiKey'));

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<TvModel>> getRecommendations(int id) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/tv/$id/recommendations?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  Future<List<TvModel>> getPopular() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/tv/popular?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  Future<List<TvModel>> getTopRated() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/tv/top_rated?$_apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  Future<List<TvModel>> search(String query) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/search/tv?$_apiKey&query=$query'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
