import 'package:ditonton/data/services/firebase_analytics.dart';
import 'package:flutter/material.dart';

final RouteObserver<ModalRoute> routeObserver =
    AnalyticsService().getAnalyticsObserver();
