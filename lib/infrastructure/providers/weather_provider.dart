import 'package:cloudy_bulletin/infrastructure/models/weather_model.dart';
import 'package:cloudy_bulletin/support/api_agent.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherProvider {
  static String apiKey = dotenv.env['WEATHER_API_KEY']!;

  ///
  /// Fetches current weather and 5-day forecast based on coordinates and unit.
  ///
  Future<WeatherModel> fetchWeatherByCoords(double lat, double lon, String unit) async {
    final apiUnit = unit == 'fahrenheit' ? 'imperial' : 'metric';
    final apiKey = 'e0aea62f2c50e2a8fc087c652d85bf56';

    //Fetches current weather
    //
    final currentUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=$apiUnit&appid=$apiKey';
    final currentJson = await ApiAgent.getJson(currentUrl);

    // Fetches 5-day forecast
    //
    final forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=$apiUnit&appid=$apiKey';
    final forecastJson = await ApiAgent.getJson(forecastUrl);

    final rawList = forecastJson['list'];
    if (rawList == null || rawList is! List) {
      throw Exception('Invalid or missing forecast data');
    }

    // Filter 1 entry per day
    //
    final filtered = <Map<String, dynamic>>[];
    final addedDays = <String>{};
    for (var f in rawList) {
      final dt = DateTime.fromMillisecondsSinceEpoch(f['dt'] * 1000);
      final day = "${dt.year}-${dt.month}-${dt.day}";
      if (!addedDays.contains(day)) {
        addedDays.add(day);
        filtered.add(f);
      }
      if (filtered.length == 5) break;
    }

    return WeatherModel.fromJson(currentJson, filtered);
  }
}
