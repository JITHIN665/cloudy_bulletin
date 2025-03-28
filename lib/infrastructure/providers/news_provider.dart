import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider {
  static const String apiKey = '6c814d3e05f54493a0be299ab4801a27';

  Future<List<NewsModel>> fetchNews(int page, List<String> keywords) async {
    final query = keywords.join(' OR ');
    final url = 'https://newsapi.org/v2/everything?q=$query&pageSize=10&page=$page&apiKey=$apiKey';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    // ✅ Safe check
    if (data['status'] != 'ok' || data['articles'] == null) {
      print('News API Error: ${data['message'] ?? 'Unknown error'}');
      return [];
    }

    final articles = data['articles'] as List;
    return articles.map((json) => NewsModel.fromJson(json)).toList();
  }
}
