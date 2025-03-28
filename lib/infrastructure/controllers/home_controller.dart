import 'package:cloudy_bulletin/helper/geolocator.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';
import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:cloudy_bulletin/infrastructure/models/weather_model.dart';
import 'package:cloudy_bulletin/infrastructure/provider/news_provider.dart';
import 'package:cloudy_bulletin/infrastructure/provider/weather_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var weatherData = Rxn<WeatherModel>();
  var newsList = <NewsModel>[].obs;
  var isLoadingMore = false.obs;
  var currentPage = 1.obs;

  final weatherProvider = WeatherProvider();
  final newsProvider = NewsProvider();

  final settingsController = Get.find<SettingsController>();

  final temperatureUnit = 'Celsius'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeatherAndNews();
  }

void fetchWeatherAndNews() async {
  final settingsController = Get.find<SettingsController>();
  final unit = settingsController.unit.value.toLowerCase();

  final position = await getCurrentPosition();
  final weather = await weatherProvider.fetchWeatherByCoords(
    position.latitude,
    position.longitude,
    unit,
  );

  weatherData.value = weather;

  currentPage.value = 1;
  newsList.clear();

  final keywords = settingsController.selectedCategories.isNotEmpty
      ? settingsController.selectedCategories
      : getKeywordsBasedOnWeather(weather.description);

  final news = await newsProvider.fetchNews(currentPage.value, keywords);
  newsList.addAll(news);
}

  void loadMoreNews() async {
    isLoadingMore.value = true;
    currentPage.value++;
    final keywords =
        settingsController.selectedCategories.isNotEmpty ? settingsController.selectedCategories : getKeywordsBasedOnWeather(weatherData.value!.description);
    // final keywords = getKeywordsBasedOnWeather(weatherData.value!.description);
    final news = await newsProvider.fetchNews(currentPage.value, keywords);
    newsList.addAll(news);
    isLoadingMore.value = false;
  }

  List<String> getKeywordsBasedOnWeather(String description) {
    if (description.contains('cold')) {
      return ['depressing', 'tragedy'];
    } else if (description.contains('hot')) {
      return ['fear', 'danger'];
    } else {
      return ['winning', 'positivity', 'happiness'];
    }
  }
}
