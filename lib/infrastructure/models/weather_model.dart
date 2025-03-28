class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final List<ForecastDay> forecast;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> currentJson, List<dynamic> forecastList) {
    return WeatherModel(
      city: currentJson['name'],
      temperature: currentJson['main']['temp'].toDouble(),
      description: currentJson['weather'][0]['description'],
      humidity: currentJson['main']['humidity'],
      windSpeed: currentJson['wind']['speed'].toDouble(),
      forecast: forecastList.map((f) => ForecastDay.fromJson(f)).toList(),
    );
  }
}

class ForecastDay {
  final String day;
  final double min;
  final double max;
  final String description;

  ForecastDay({
    required this.day,
    required this.min,
    required this.max,
    required this.description,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    return ForecastDay(
      day: "${dateTime.weekday}",
      min: json['main']['temp_min'].toDouble(),
      max: json['main']['temp_max'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}