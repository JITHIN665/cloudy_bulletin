import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';
import 'package:cloudy_bulletin/module/home/widgets/news_card.dart';
import 'package:cloudy_bulletin/module/home/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather & News'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed:
                () => Get.toNamed('/settings')?.then((_) {
                  // 👇 Automatically refresh when returning from Settings
                  Get.find<HomeController>().fetchWeatherAndNews();
                }),
          ),
        ],
      ),
      body: Obx(() {
        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoadingMore.value && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              controller.loadMoreNews();
            }
            return false;
          },
          child: ListView(
            children: [
              if (controller.weatherData.value != null) WeatherCard(weather: controller.weatherData.value!,unit: controller.settingsController.unit.value,),
              ...controller.newsList.map((news) => NewsCard(news: news)),
              if (controller.isLoadingMore.value) Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      }),
    );
  }
}
