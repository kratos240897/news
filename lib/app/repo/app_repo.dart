// ignore_for_file: avoid_print



import './../models/news_response.dart';
import '../helpers/constants.dart';
import '../service/api_service.dart';

abstract class AppRepository {
  Future<List<Articles>> getNews();
  Future<List<Articles>> searchNews(String query);
  void init();
}

class AppRepo extends AppRepository {
  final ApiService apiService;
  AppRepo({required this.apiService});

  @override
  void init() {
    apiService.addInterceptor();
  }

  @override
  Future<List<Articles>> getNews() async {
    try {
      final res = await apiService.getRequest(
          Constants.HEADLINES, {'country': 'IN', 'category': 'business'});
      final newsResponse = NewsResponse.fromJson(res.data);
      return newsResponse.articles;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  @override
  Future<List<Articles>> searchNews(String query) async {
    try {
      final res = await apiService.getRequest(Constants.SEARCH, {'q': query});
      final newsResponse = NewsResponse.fromJson(res.data);
      return newsResponse.articles;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
