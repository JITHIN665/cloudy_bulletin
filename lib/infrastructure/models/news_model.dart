class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      url: json['url'],
      publishedAt: json['publishedAt'],
    );
  }
}
