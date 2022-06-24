import 'package:ditonton/domain/entities/content_arguments.dart';
import 'package:ditonton/domain/entities/search_arguments.dart';
import 'package:ditonton/presentation/pages/detail_page.dart';
import 'package:ditonton/presentation/pages/home_page.dart';
import 'package:ditonton/presentation/pages/movie/movie_popular.dart';
import 'package:ditonton/presentation/pages/movie/movie_top_rated.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_popular.dart';
import 'package:ditonton/presentation/pages/tv/tv_top_rated.dart';
import 'package:ditonton/presentation/pages/unknown_page.dart';
import 'package:flutter/material.dart';

part 'route_name_helper.dart';

class RouteHelper {
  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    final routeName = settings?.name;
    final arguments = settings?.arguments;

    switch (routeName) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case movieTopRatedRoute:
        return MaterialPageRoute(
          builder: (_) => const MovieTopRatedPage(),
          settings: settings,
        );
      case moviePopularRoute:
        return MaterialPageRoute(
          builder: (_) => const MoviePopularPage(),
          settings: settings,
        );
      case tvTopRatedRoute:
        return MaterialPageRoute(
          builder: (_) => const TvTopRatedPage(),
          settings: settings,
        );
      case tvPopularRoute:
        return MaterialPageRoute(
          builder: (_) => const TvPopularPage(),
          settings: settings,
        );
      case detailRoute:
        if (arguments is ContentArguments) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(arguments: arguments),
            settings: settings,
          );
        }
        return MaterialPageRoute(builder: (_) => const UnknownPage());
      case searchRoute:
        if (arguments is SearchArguments) {
          return MaterialPageRoute(
            builder: (_) => SearchPage(arguments: arguments),
            settings: settings,
          );
        }
        return MaterialPageRoute(builder: (_) => const UnknownPage());
      default:
        return MaterialPageRoute(builder: (_) => const UnknownPage());
    }
  }
}
