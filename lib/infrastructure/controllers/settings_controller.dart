import 'package:get/get.dart';

class SettingsController extends GetxController {
  var unit = 'Celsius'.obs;
  var categories = [
    'business', 'crime', 'domestic', 'education', 'entertainment',
    'environment', 'food', 'health', 'lifestyle', 'other',
    'politics', 'science', 'sports', 'technology', 'top',
    'tourism', 'world'
  ];
  var selectedCategories = <String>[].obs;

  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      if (selectedCategories.length < 5) {
        selectedCategories.add(category);
      }
    }
  }

  void setUnit(String value) {
    unit.value = value;
  }
}
