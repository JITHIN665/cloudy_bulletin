import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsProvider {
  static const String apiKey = '44a0b391e797410e880a65103d8dd4a2';

  Future<List<NewsModel>> fetchNews(int page, List<String> keywords) async {
    final query = keywords.join(' OR ');
    final url =
        'https://newsapi.org/v2/everything?q=$query&pageSize=10&page=$page&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    return (data['articles'] as List)
        .map((json) => NewsModel.fromJson(json))
        .toList();
  }

  
}
