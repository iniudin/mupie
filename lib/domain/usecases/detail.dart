import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class DetailUsecase {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  DetailUsecase(this.movieRepository, this.tvRepository);

  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) {
    return movieRepository.getDetail(id);
  }

  Future<Either<Failure, List<Movie>>> getMovieRecommendations(id) {
    return movieRepository.getRecommendations(id);
  }

  Future<Either<Failure, List<Tv>>> getTvRecommendations(id) {
    return tvRepository.getRecommendations(id);
  }

  Future<Either<Failure, TvDetail>> getTvDetail(int id) {
    return tvRepository.getDetail(id);
  }
}
