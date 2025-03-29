import 'package:cloudy_bulletin/support/helper.dart';
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
            ],
          ),
          SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${weather.temperature.toStringAsFixed(0)}$symbol',
                style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(width: 10),
              SizedBox(height: 90, child: Lottie.asset(animationPath)),
            ],
          ),
          Text(weather.description.capitalizeFirst ?? '', style: TextStyle(fontSize: 20, color: Colors.white)),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              weatherCondition("Precip", "30%", Icons.grain),
              weatherCondition("Humidity", "${weather.humidity}%", Icons.opacity),
              weatherCondition("Wind", "${weather.windSpeed} km/h", Icons.air_outlined),
            ],
          ),
          SizedBox(height: 30),
          Text("5-Day Forecast", style: TextStyle(fontSize: 16, color: Colors.white)),
          SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weather.forecast.length.clamp(0, 5),
              itemBuilder: (context, index) {
                final data = weather.forecast[index];
                final date = DateTime.now().add(Duration(days: index));
                final day = getWeekdayName(date);
                final forecastAnim = getWeatherAnimation(data.description);
                return Container(
                  width: 70,
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(day, style: TextStyle(color: Colors.white, fontSize: 14)),
                      SizedBox(height: 30, child: Lottie.asset(forecastAnim)),
                      Text(
                        '${data.min.toStringAsFixed(0)}/${data.max.toStringAsFixed(0)}$symbol',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
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

  Widget weatherCondition(String title, String value, IconData icon) {
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
