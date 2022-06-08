import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class SearchUsecase {
  final MovieRepository movieRepository;
  final TvRepository tvRepository;

  SearchUsecase(this.movieRepository, this.tvRepository);

  Future<Either<Failure, List<Movie>>> searchMovie(String query) {
    return movieRepository.search(query);
  }

  Future<Either<Failure, List<Tv>>> searchTv(String query) {
    return tvRepository.search(query);
  }
}
