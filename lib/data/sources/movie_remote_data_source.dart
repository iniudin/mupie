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
    return await this.movieService.getDetail(id);
  }

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    return await this.movieService.getNowPlaying();
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    return await this.movieService.getPopular();
  }

  @override
  Future<List<MovieModel>> getRecommendations(int id) async {
    return await this.movieService.getRecommendations(id);
  }

  @override
  Future<List<MovieModel>> getTopRated() async {
    return await this.movieService.getTopRated();
  }

  @override
  Future<List<MovieModel>> search(String query) async {
    return await this.movieService.search(query);
  }
}
