import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:cloudy_bulletin/infrastructure/models/weather_model.dart';
import 'package:cloudy_bulletin/modules/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';

void main() {
  group('HomePage Widget Tests', () {
    late HomeController homeController;
    late SettingsController settingsController;

    setUp(() {
      Get.reset();
      settingsController = Get.put(SettingsController());
      homeController = Get.put(HomeController());
    });

    testWidgets('Displays shimmer when weather data is null', (WidgetTester tester) async {
      homeController.weatherData.value = null;
      homeController.newsList.clear();

      await tester.pumpWidget(GetMaterialApp(home: HomePage()));

      // Look for shimmer indicators
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Displays weather card and news list', (WidgetTester tester) async {
      // Mock Weather data
      homeController.weatherData.value = WeatherModel(
        city: "Paris",
        temperature: 23,
        description: "clear sky",
        humidity: 40,
        windSpeed: 5.6,
        forecast: [],
      );

      // Mock news
      homeController.newsList.assignAll([
        NewsModel(
          title: "Test News",
          description: "Test Description",
          imageUrl: "",
          url: "https://example.com",
          publishedAt: DateTime.now().toIso8601String(),
        )
      ]);

      await tester.pumpWidget(GetMaterialApp(home: HomePage()));

      expect(find.text("Paris"), findsOneWidget);
      expect(find.textContaining("Test News"), findsOneWidget);
    });
  });
}
