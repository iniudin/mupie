import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';

class MovieUsecase {
  final MovieRepository movieRepository;

  MovieUsecase(this.movieRepository);

  Future<Either<Failure, List<Movie>>> getNowPlaying() {
    return movieRepository.getNowPlaying();
  }

  Future<Either<Failure, List<Movie>>> getPopular() {
    return movieRepository.getPopular();
  }

  Future<Either<Failure, List<Movie>>> getTopRated() {
    return movieRepository.getTopRated();
  }
}
