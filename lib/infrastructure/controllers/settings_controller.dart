import 'package:get/get.dart';
import 'home_controller.dart';

class SettingsController extends GetxController {
  var unit = 'Celsius'.obs;

  var categories = [
    'business',
    'crime',
    'domestic',
    'education',
    'entertainment',
    'environment',
    'food',
    'health',
    'lifestyle',
    'other',
    'politics',
    'science',
    'sports',
    'technology',
    'top',
    'tourism',
    'world',
  ];

  var selectedCategories = <String>[].obs;

  /// 
  /// Toggles a news category selection (max 5).
  /// 
  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      if (selectedCategories.length < 5) {
        selectedCategories.add(category);
      }
    }
    notifyHome();
  }

  /// 
  /// Sets the temperature unit and triggers a refresh.
  /// 
  void setUnit(String value) {
    unit.value = value;
    notifyHome(temp: true);
  }

  /// 
  /// Notifies the HomeController to refresh data.
  /// 
  void notifyHome({bool? temp}) {
    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().fetchWeatherAndNews(temp:temp);
    }
  }
}
