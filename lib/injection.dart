import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/data/services/database_service.dart';
import 'package:ditonton/data/sources/movie_remote_data_source.dart';
import 'package:ditonton/data/sources/tv_remote_data_source.dart';
import 'package:ditonton/data/sources/watchlist_local_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';
import 'package:ditonton/domain/usecases/detail.dart';
import 'package:ditonton/domain/usecases/movie.dart';
import 'package:ditonton/domain/usecases/search.dart';
import 'package:ditonton/domain/usecases/tv.dart';
import 'package:ditonton/domain/usecases/watchlist.dart';
import 'package:ditonton/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_on_playing/movie_on_playing_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_search/movie_search_bloc.dart';
import 'package:ditonton/presentation/blocs/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_on_the_air/tv_on_the_air_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_popular/tv_popular_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_search/tv_search_bloc.dart';
import 'package:ditonton/presentation/blocs/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/utils/ssl/ssl_pinning.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  IOClient ioClient = await SSLPinning.ioClient;

  getIt.registerFactory<MovieOnPlayingBloc>(
    () => MovieOnPlayingBloc(usecase: getIt()),
  );

  getIt.registerFactory<MoviePopularBloc>(
    () => MoviePopularBloc(usecase: getIt()),
  );

  getIt.registerFactory<MovieTopRatedBloc>(
    () => MovieTopRatedBloc(usecase: getIt()),
  );

  getIt.registerFactory<MovieDetailBloc>(
    () => MovieDetailBloc(usecase: getIt()),
  );
  getIt.registerFactory<MovieRecommendationBloc>(
    () => MovieRecommendationBloc(usecase: getIt()),
  );
  getIt.registerFactory<MovieSearchBloc>(
    () => MovieSearchBloc(usecase: getIt()),
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

  getIt.registerFactory<TvDetailBloc>(
    () => TvDetailBloc(usecase: getIt()),
  );

  getIt.registerFactory<TvRecommendationBloc>(
    () => TvRecommendationBloc(usecase: getIt()),
  );

  getIt.registerFactory<TvSearchBloc>(
    () => TvSearchBloc(usecase: getIt()),
  );

  getIt.registerFactory<WatchlistBloc>(
    () => WatchlistBloc(
      detailUsecase: getIt(),
      watchlistUsecase: getIt(),
    ),
  );

  /// Initialize for Services
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());

  /// Initialize for Data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSource(
      httpClient: getIt(),
      ioClient: getIt(),
    ),
  );
  getIt.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSource(
      httpClient: getIt(),
      ioClient: getIt(),
    ),
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
  getIt.registerLazySingleton<DetailUsecase>(
    () => DetailUsecase(
      movieRepository: getIt(),
      tvRepository: getIt(),
      watchlistRepository: getIt(),
    ),
  );
  getIt.registerLazySingleton<SearchUsecase>(
    () => SearchUsecase(
      movieRepository: getIt(),
      tvRepository: getIt(),
    ),
  );

  // external
  getIt.registerFactory<IOClient>(() => ioClient);
  getIt.registerFactory<http.Client>(() => http.Client());
}
