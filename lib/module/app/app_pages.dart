import 'package:cloudy_bulletin/module/home/views/home_page.dart';
import 'package:cloudy_bulletin/module/settings/settings_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const HOME = '/';
  static const SETTINGS = '/settings';
}

class AppPages {
  static final routes = [
    GetPage(name: AppRoutes.HOME, page: () => HomePage()),
    GetPage(name: AppRoutes.SETTINGS, page: () => SettingsPage()),
  ];
}
