import 'package:ditonton/presentation/pages/home_page.dart';
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
      default:
        return MaterialPageRoute(builder: (_) => const UnknownPage());
    }
  }
}
