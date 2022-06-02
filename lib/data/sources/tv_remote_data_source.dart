import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/services/tv_service.dart';

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlaying();
  Future<TvDetailResponse> getDetail(int id);
  Future<List<TvModel>> getRecommendations(int id);
  Future<List<TvModel>> getPopular();
  Future<List<TvModel>> getTopRated();
  Future<List<TvModel>> search(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final TvService tvService;

  TvRemoteDataSourceImpl(this.tvService);

  @override
  Future<TvDetailResponse> getDetail(int id) async {
    return await this.tvService.getDetail(id);
  }

  @override
  Future<List<TvModel>> getNowPlaying() async {
    return await this.tvService.getNowPlaying();
  }

  @override
  Future<List<TvModel>> getPopular() async {
    return await this.tvService.getPopular();
  }

  @override
  Future<List<TvModel>> getRecommendations(int id) async {
    return await this.tvService.getRecommendations(id);
  }

  @override
  Future<List<TvModel>> getTopRated() async {
    return await this.tvService.getTopRated();
  }

  @override
  Future<List<TvModel>> search(String query) async {
    return await this.tvService.search(query);
  }
}
