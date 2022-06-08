import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class TvUsecase {
  final TvRepository tvRepository;

  TvUsecase(this.tvRepository);

  Future<Either<Failure, List<Tv>>> getNowPlaying() {
    return tvRepository.getNowPlaying();
  }

  Future<Either<Failure, List<Tv>>> getPopular() {
    return tvRepository.getPopular();
  }

  Future<Either<Failure, List<Tv>>> getTopRated() {
    return tvRepository.getTopRated();
  }
}
