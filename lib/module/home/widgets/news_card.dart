import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12),
      child: Column(
        children: [
          if (news.imageUrl.isNotEmpty)
            Image.network(news.imageUrl, height: 180, fit: BoxFit.cover),
          ListTile(
            title: Text(news.title),
            subtitle: Text(news.description),
            trailing: Text(news.publishedAt.split('T')[0]),
          ),
        ],
      ),
    );
  }
}
