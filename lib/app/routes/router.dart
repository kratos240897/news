// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider_news/app/models/news_response.dart';
import 'package:provider_news/app/screens/web_view/webview.dart';

import '../screens/detail/detail.dart';
import '../screens/home/home.dart';
import '../screens/search/search.dart';

class AppRouter {
  static const HOME = '/';
  static const SEARCH = '/search';
  static const DETAIL = '/detail';
  static const WEB_VIEW = '/webview';

  Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case HOME:
        return MaterialPageRoute(builder: (_) => const Home());
      case SEARCH:
        return MaterialPageRoute(builder: (_) => const Search());
      case DETAIL:
        return MaterialPageRoute(
            builder: (_) => Detail(article: args as Articles));
      case WEB_VIEW:
        return MaterialPageRoute(
            builder: (_) => WebViewScreen(newsUrl: args as String));
    }
    return null;
  }
}
