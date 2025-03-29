String getWeatherAnimation(String description) {
  description = description.toLowerCase();
  if (description.contains('clear sky')) return 'assets/lottie/sunny.json';
  if (description.contains('few clouds')) return 'assets/lottie/cloudy.json';
  if (description.contains('light rain')) return 'assets/lottie/rainy.json';
  if (description.contains('storm')) return 'assets/lottie/storm.json';
  if (description.contains('snow')) return 'assets/lottie/snow.json';
  return 'assets/lottie/cloudy.json'; 
}


  String getWeekdayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
