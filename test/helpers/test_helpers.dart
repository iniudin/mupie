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
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart' as tail;

class MockMovieOnPlayingBloc extends tail.Mock implements MovieOnPlayingBloc {}

class MockMoviePopularBloc extends tail.Mock implements MoviePopularBloc {}

class MockMovieTopRatedBloc extends tail.Mock implements MovieTopRatedBloc {}

class MockMovieDetailBloc extends tail.Mock implements MovieDetailBloc {}

class MockMovieRecommendationBloc extends tail.Mock
    implements MovieRecommendationBloc {}

class MockMovieSearchBloc extends tail.Mock implements MovieSearchBloc {}

class MockTvOnTheAirBloc extends tail.Mock implements TvOnTheAirBloc {}

class MockTvPopularBloc extends tail.Mock implements TvPopularBloc {}

class MockTvTopRatedBloc extends tail.Mock implements TvTopRatedBloc {}

class MockTvDetailBloc extends tail.Mock implements TvDetailBloc {}

class MockTvRecommendationBloc extends tail.Mock
    implements TvRecommendationBloc {}

class MockTvSearchBloc extends tail.Mock implements TvSearchBloc {}

@GenerateMocks([
  DatabaseService,
  MovieRemoteDataSource,
  MovieRepository,
  MovieUsecase,
  TvRemoteDataSource,
  TvRepository,
  TvUsecase,
  DetailUsecase,
  SearchUsecase,
  WatchlistLocalDataSource,
  WatchlistRepository,
  WatchlistUsecase
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
