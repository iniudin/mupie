import 'package:ditonton/data/models/movie_detail_model.dart';
import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/services/movie_service.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<MovieDetailResponse> getDetail(int id);
  Future<List<MovieModel>> getRecommendations(int id);
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getTopRated();
  Future<List<MovieModel>> search(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final MovieService movieService;

  MovieRemoteDataSourceImpl(this.movieService);

  @override
  Future<MovieDetailResponse> getDetail(int id) async {
    return await movieService.getDetail(id);
  }

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    return await movieService.getNowPlaying();
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    return await movieService.getPopular();
  }

  @override
  Future<List<MovieModel>> getRecommendations(int id) async {
    return await movieService.getRecommendations(id);
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    return await movieService.getTopRated();
  }

  @override
  Future<List<MovieModel>> search(String query) async {
    return await movieService.search(query);
  }
}
