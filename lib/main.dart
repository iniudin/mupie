import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/blocs/Tv/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/blocs/home/home_index_cubit.dart';
import 'package:ditonton/presentation/blocs/movie/on_playing/on_playing_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/popular/popular_bloc.dart';
import 'package:ditonton/presentation/blocs/movie/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/on_the_air/on_the_air_bloc.dart';
import 'package:ditonton/presentation/blocs/tv/popular/popular_bloc.dart';
import 'package:ditonton/utils/navigation/navigation_helper.dart';
import 'package:ditonton/utils/route/route_helper.dart';
import 'package:ditonton/utils/route/route_observer_helper.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.getIt<HomeIndexCubit>(),
        ),
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
          create: (context) => di.getIt<TvOnTheAirBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (context) => di.getIt<TvPopularBloc>(),
        ),
      ],
      child: MaterialApp(
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
