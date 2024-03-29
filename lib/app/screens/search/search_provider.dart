import 'package:flutter/material.dart';
import 'package:provider_news/app/repo/app_repo.dart';

import '../../data/models/news_response.dart';

class SearchProvider extends ChangeNotifier {
  final List<Articles> articles = [];
  var isLoading = false;
  final AppRepository appRepository;
  bool cancelVisible = false;

  SearchProvider({required this.appRepository});

  showLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  updateUI() {
    notifyListeners();
  }

  search(String query) {
    showLoading(true);
    appRepository.searchNews(query).then((value) async {
      articles.clear();
      articles.addAll(value);
      notifyListeners();
      showLoading(false);
    });
  }
}
