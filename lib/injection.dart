import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/data/services/database_service.dart';
import 'package:ditonton/data/services/movie_service.dart';
import 'package:ditonton/data/services/tv_service.dart';
import 'package:ditonton/data/sources/movie_remote_data_source.dart';
import 'package:ditonton/data/sources/tv_remote_data_source.dart';
import 'package:ditonton/data/sources/watchlist_local_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:ditonton/domain/usecases/tv.dart';
import 'package:ditonton/domain/usecases/watchlist.dart';
import 'package:ditonton/presentation/blocs/home/home_index_cubit.dart';
import 'package:ditonton/presentation/blocs/movie/on_playing/on_playing_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/on_the_air/on_the_air_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/top_rated/top_rated_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void init() {
  getIt.registerFactory<HomeIndexCubit>(
    () => HomeIndexCubit(),
  );
  getIt.registerFactory<MovieOnPlayingBloc>(
    () => MovieOnPlayingBloc(usecase: getIt()),
  );
  getIt.registerFactory<MoviePopularBloc>(
    () => MoviePopularBloc(usecase: getIt()),
  );
  getIt.registerFactory<MovieTopRatedBloc>(
    () => MovieTopRatedBloc(usecase: getIt()),
  );
  getIt.registerFactory<TvOnTheAirBloc>(
    () => TvOnTheAirBloc(usecase: getIt()),
  );
  getIt.registerFactory<TvPopularBloc>(
    () => TvPopularBloc(usecase: getIt()),
  );
  getIt.registerFactory<TvTopRatedBloc>(
    () => TvTopRatedBloc(usecase: getIt()),
  );

  /// Initialize for Services
  getIt.registerLazySingleton<MovieService>(() => MovieService());
  getIt.registerLazySingleton<TvService>(() => TvService());
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());

  /// Initialize for Data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(getIt()),
  );
  getIt.registerLazySingleton<WatchlistLocalDataSource>(
    () => WatchlistLocalDataSourceImpl(getIt()),
  );

  /// Initialize for Repository
  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(movieRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(tvRemoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(localDataSource: getIt()),
  );

  /// Initialize for Usecases
  getIt.registerLazySingleton<MovieUsecase>(
    () => MovieUsecase(getIt()),
  );
  getIt.registerLazySingleton<TvUsecase>(
    () => TvUsecase(getIt()),
  );
  getIt.registerLazySingleton<WatchlistUsecase>(
    () => WatchlistUsecase(getIt()),
  );

  // external
  getIt.registerLazySingleton(() => http.Client());
}
