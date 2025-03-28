import 'package:cloudy_bulletin/helper/helper.dart';
import 'package:cloudy_bulletin/infrastructure/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final String unit;

  const WeatherCard({super.key, required this.weather, required this.unit});

  @override
  Widget build(BuildContext context) {
    String symbol = unit == 'Fahrenheit' ? '°F' : '°C';
    String animationPath = getWeatherAnimation(weather.description);

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white),
                  SizedBox(width: 4),
                  Text(weather.city, style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              Icon(Icons.more_vert, color: Colors.white),
            ],
          ),
          SizedBox(height: 20),

          // Temperature + animation
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${weather.temperature.toStringAsFixed(0)}$symbol',
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 10),
              SizedBox(height: 60, child: Lottie.asset(animationPath)),
            ],
          ),
          Text(weather.description.capitalizeFirst ?? '', style: TextStyle(fontSize: 20, color: Colors.white)),
          SizedBox(height: 20),

          // Metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _metricColumn("Precip", "30%", Icons.grain),
              _metricColumn("Humidity", "${weather.humidity}%", Icons.opacity),
              _metricColumn("Wind", "${weather.windSpeed} km/h", Icons.air_outlined),
            ],
          ),
          SizedBox(height: 30),

          // 5-Day Forecast
          Text("5-Day Forecast", style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 10),

          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.forecast.length.clamp(0, 5),
              itemBuilder: (context, index) {
                final f = weather.forecast[index];
                final date = DateTime.now().add(Duration(days: index));
                final day = _getWeekdayName(date);
                final forecastAnim = getWeatherAnimation(f.description);
                print(f.description);
                return Container(
                  width: 70,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(day, style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(
                        height: 30,
                        child: Lottie.asset(forecastAnim), // 🎞 Lottie animation here
                      ),
                      Text('${f.min.toStringAsFixed(0)}/${f.max.toStringAsFixed(0)}$symbol', style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekdayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  Widget _metricColumn(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(height: 4),
        Text(value, style: TextStyle(color: Colors.white)),
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
