import 'package:ditonton/data/services/movie_service.dart';
import 'package:ditonton/data/services/tv_service.dart';
import 'package:ditonton/data/source/movie_remote_data_source.dart';
import 'package:ditonton/data/source/tv_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
  MovieService,
  TvService
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
