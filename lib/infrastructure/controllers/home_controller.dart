import 'package:cloudy_bulletin/support/geolocator.dart';
import 'package:cloudy_bulletin/infrastructure/controllers/settings_controller.dart';
import 'package:cloudy_bulletin/infrastructure/models/news_model.dart';
import 'package:cloudy_bulletin/infrastructure/models/weather_model.dart';
import 'package:cloudy_bulletin/infrastructure/providers/news_provider.dart';
import 'package:cloudy_bulletin/infrastructure/providers/weather_provider.dart';
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

  ///
  /// Called when the controller is initialized.
  ///
  @override
  void onInit() {
    super.onInit();
    fetchWeatherAndNews();
  }

  ///
  /// Fetches weather and news based on current location and user settings.
  ///
  void fetchWeatherAndNews({bool? temp}) async {
    if (temp == true) weatherData.value = null;
    newsList.clear();
    final settingsController = Get.find<SettingsController>();
    final unit = settingsController.unit.value.toLowerCase();

    final position = await getCurrentPosition();
    final weather = await weatherProvider.fetchWeatherByCoords(position.latitude, position.longitude, unit);

    weatherData.value = weather;

    currentPage.value = 1;
    newsList.clear();

    final keywords =
        settingsController.selectedCategories.isNotEmpty ? settingsController.selectedCategories : getKeywordsBasedOnWeather(weather.description);

    final news = await newsProvider.fetchNews(currentPage.value, keywords);
    newsList.addAll(news);
  }

  ///
  /// Loads additional news articles for pagination.
  ///
  void loadMoreNews() async {
    isLoadingMore.value = true;
    currentPage.value++;
    final keywords =
        settingsController.selectedCategories.isNotEmpty
            ? settingsController.selectedCategories
            : getKeywordsBasedOnWeather(weatherData.value!.description);
    final news = await newsProvider.fetchNews(currentPage.value, keywords);
    newsList.addAll(news);
    isLoadingMore.value = false;
  }

  ///
  /// Returns a list of news keywords based on the current weather description.
  ///
  List<String> getKeywordsBasedOnWeather(String description) {
    description = description.toLowerCase();

    if (description.contains('snow') || description.contains('mist') || description.contains('fog') || description.contains('cold')) {
      return ['depressing', 'tragedy'];
    } else if (description.contains('rain') ||
        description.contains('storm') ||
        description.contains('thunder') ||
        description.contains('hot') ||
        description.contains('extreme')) {
      return ['fear', 'danger'];
    } else {
      return ['winning', 'positivity', 'happiness'];
    }
  }
}
