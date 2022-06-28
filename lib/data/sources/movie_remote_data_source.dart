import 'dart:convert';

import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/movie_response.dart';
import 'package:ditonton/common/exception.dart';
import 'package:http/http.dart' as http;

class MovieRemoteDataSource {
  static const _apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const _baseUrl = 'https://api.themoviedb.org/3';

  final http.Client _client;

  MovieRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<MovieModel>> getNowPlaying() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/movie/now_playing?$_apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  Future<MovieDetailModel> getDetail(int id) async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/movie/$id?$_apiKey'));

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Future<List<MovieModel>> getRecommendations(int id) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/movie/$id/recommendations?$_apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  Future<List<MovieModel>> getPopular() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/movie/popular?$_apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  Future<List<MovieModel>> getTopRated() async {
    final response =
        await _client.get(Uri.parse('$_baseUrl/movie/top_rated?$_apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  Future<List<MovieModel>> search(String query) async {
    final response = await _client
        .get(Uri.parse('$_baseUrl/search/movie?$_apiKey&query=$query'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
