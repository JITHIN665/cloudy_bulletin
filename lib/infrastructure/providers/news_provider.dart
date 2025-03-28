import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:cloudy_bulletin/support/api_agent.dart';

class NewsProvider {
  static const String apiKey = 'c2c413efabf241c0b667f5895a953170';

  /// 
  /// Fetches news articles and sorts them by publish date (latest first).
  /// 
  Future<List<NewsModel>> fetchNews(int page, List<String> keywords) async {
    final query = keywords.join(' OR ');
    final url = 'https://newsapi.org/v2/everything?q=$query&pageSize=10&page=$page&apiKey=$apiKey';

    final data = await ApiAgent.getJson(url);

    if (data['status'] != 'ok' || data['articles'] == null) {
      return [];
    }

    final articles = data['articles'] as List;

    // Sort by publishedAt descending (newest first)
    articles.sort((a, b) => DateTime.parse(b['publishedAt']).compareTo(DateTime.parse(a['publishedAt'])));

    return articles.map((json) => NewsModel.fromJson(json)).toList();
  }
}
