import 'package:cloudy_bulletin/infrastructure/controllers/home_controller.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';
import 'package:cloudy_bulletin/modules/app/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xFFf3e9fc),
        primaryColor: Color(0xFFa18cd1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFfbc2eb),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Color.fromARGB(255, 209, 199, 233), foregroundColor: Colors.white, elevation: 0),
        textTheme: TextTheme(titleLarge: TextStyle(fontSize: 20, color: Colors.white), bodyMedium: TextStyle(color: Color(0xFF333333))),
        chipTheme: ChipThemeData(selectedColor: Color(0xFFa18cd1), backgroundColor: Colors.grey.shade200, labelStyle: TextStyle(color: Colors.black)),
      ),

      title: 'Weather & News Aggregator',
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(SettingsController());
        Get.put(HomeController());
      }),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.SPLASH,
    );
  }
}
