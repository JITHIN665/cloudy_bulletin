import 'package:cloudy_bulletin/infrastructure/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider {
  static const String apiKey = 'e0aea62f2c50e2a8fc087c652d85bf56';

Future<WeatherModel> fetchWeatherByCoords(double lat, double lon, String unit) async {
  final apiUnit = unit == 'fahrenheit' ? 'imperial' : 'metric';
  final apiKey = 'e0aea62f2c50e2a8fc087c652d85bf56';

  // 1. Current Weather
  final currentUrl =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=$apiUnit&appid=$apiKey';
  final currentRes = await http.get(Uri.parse(currentUrl));
  final currentJson = json.decode(currentRes.body);

  // 2. 5-day Forecast
  final forecastUrl =
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=$apiUnit&appid=$apiKey';
  final forecastRes = await http.get(Uri.parse(forecastUrl));
  final forecastJson = json.decode(forecastRes.body);

  // ✅ Safe check for forecast list
  final rawList = forecastJson['list'];
  if (rawList == null || rawList is! List) {
    throw Exception('Invalid or missing forecast data');
  }

  // ✅ Filter 1 entry per day
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
