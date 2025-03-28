import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.parse(news.publishedAt));

    return GestureDetector(
      onTap: () => _launchUrl(news.url),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  news.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => Container(height: 180, color: Colors.grey.shade200, child: Center(child: Icon(Icons.broken_image, size: 40))),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                  SizedBox(height: 6),
                  Text(news.description, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(publishedDate, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
}
