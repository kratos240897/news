import 'package:flutter/material.dart';
import '../../models/news_response.dart';
import '../../repo/app_repo.dart';

class HomeProvider extends ChangeNotifier {
  final AppRepository appRepository;
  var isLoading = true;
  final topics = ['Now', 'War', 'Covid', 'Russia', 'Cinema'];
  final Map<String, List<Articles>> categoriesMap = {};

  HomeProvider({required this.appRepository}) {
    for (String i in topics) {
      categoriesMap[i] = [];
    }
  }

  showLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  void getNews() {
    showLoading(true);
    appRepository.getNews().then((value) async {
      categoriesMap[topics[0]]?.clear();
      categoriesMap[topics[0]]?.addAll(value);
      notifyListeners();
      showLoading(false);
    });
  }

  search(int index) {
    final query = topics[index];
    final articles = categoriesMap[query];
    if (articles!.isEmpty) {
      showLoading(true);
      appRepository.searchNews(query).then((value) async {
        articles.clear();
        articles.addAll(value);
        notifyListeners();
        showLoading(false);
      });
    }
  }
}
