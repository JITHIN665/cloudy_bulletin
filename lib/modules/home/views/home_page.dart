import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';
import 'package:cloudy_bulletin/modules/home/widgets/news_card.dart';
import 'package:cloudy_bulletin/modules/home/widgets/weather_card.dart';
import 'package:cloudy_bulletin/themes/widgets/shimmer_news_card.dart';
import 'package:cloudy_bulletin/themes/widgets/shimmer_weather_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Image.asset("assets/icons/logo.png"),
        title: Text("Cloudy Bulletin", style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700)),
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () => Get.toNamed('/settings'))],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 209, 199, 233), Color.fromARGB(255, 238, 201, 227)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoadingMore.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                controller.loadMoreNews();
              }
              return false;
            },
            child: ListView(
              children: [
                controller.weatherData.value == null
                    ? Center(child: ShimmerWeatherCard())
                    : Column(
                      children: [
                        controller.weatherData.value == null
                            ? ShimmerWeatherCard()
                            : WeatherCard(weather: controller.weatherData.value!, unit: controller.settingsController.unit.value),
                        controller.newsList.isEmpty
                            ? Column(children: List.generate(3, (_) => ShimmerNewsCard()))
                            : Column(children: controller.newsList.map((news) => NewsCard(news: news)).toList()),
                        if (controller.isLoadingMore.value) Padding(padding: const EdgeInsets.all(12), child: CircularProgressIndicator()),
                      ],
                    ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
