import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<Tv>>> onTheAir();
  Future<Either<Failure, List<Tv>>> getPopular();
  Future<Either<Failure, List<Tv>>> getTopRated();
  Future<Either<Failure, TvDetail>> getDetail(int id);
  Future<Either<Failure, List<Tv>>> getRecommendations(int id);
  Future<Either<Failure, List<Tv>>> search(String query);
}
