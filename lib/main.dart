import 'package:ditonton/common/constants.dart';
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
import 'package:ditonton/utils/navigation/navigation_helper.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:ditonton/utils/route/route_observer_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:ditonton/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await FirebaseAnalytics.instance.logEvent(
    name: 'app_open',
    parameters: <String, dynamic>{
      'app_name': 'Ditonton',
      'app_version': '1.0.0',
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<MovieOnPlayingBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvRecommendationBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvSearchBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<WatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ditonton App',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        navigatorObservers: [routeObserver],
        initialRoute: homeRoute,
        onGenerateRoute: RouteHelper.generateRoute,
        navigatorKey: NavigationHelper.navigatorKey,
      ),
    );
  }
}
