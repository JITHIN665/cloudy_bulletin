import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';
import 'package:cloudy_bulletin/module/app/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Weather & News Aggregator',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(SettingsController()); // 🔥 persist settings globally
        Get.put(HomeController());
      }),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.HOME,
    );
  }
}
