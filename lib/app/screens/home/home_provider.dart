import 'package:flutter/material.dart';
import 'package:provider_news/app/data/cache/cache_repository.dart';
import '../../data/models/news_response.dart';
import '../../repo/app_repo.dart';

class HomeProvider extends ChangeNotifier {
  final AppRepository appRepository;
  var isLoading = true;
  final topics = [
    '👉🏻 Now',
    '🌍 World',
    '🎮 Games',
    '💻 Tech',
    '📚 Education'
  ];
  final List<Articles> articles = [];

  HomeProvider({required this.appRepository});

  showLoading(bool isLoading) {
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<void> getNews() async {
    showLoading(true);
    final result = await CacheRepo.homeCache.get('0');
    if (result != null) {
      articles.clear();
      articles.addAll(result);
      notifyListeners();
      showLoading(false);
    } else {
      appRepository.getNews().then((value) async {
        cacheResponse('0', value);
        articles.clear();
        articles.addAll(value);
        notifyListeners();
        showLoading(false);
      });
    }
  }

  void cacheResponse(String key, List<Articles> value) {
    CacheRepo.homeCache.set(key, value);
  }

  Future<void> setSelectedTopic(int index) async {
    final result = await CacheRepo.homeCache.get(index.toString());
    if (result != null) {
      articles.clear();
      articles.addAll(result);
      notifyListeners();
    } else {
      final query = topics[index];
      appRepository.searchNews(query).then((value) async {
        cacheResponse(index.toString(), value);
        articles.clear();
        articles.addAll(value);
        notifyListeners();
      });
    }
  }
}
