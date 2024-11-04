class Forecast {
  final List<DailyForecast> daily; // Changed to non-nullable list

  Forecast({required this.daily}); // Required constructor

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      daily: (json['daily'] as List<dynamic>) // Cast to List<dynamic>
          .map((item) => DailyForecast.fromJson(item)) // Convert each item to DailyForecast
          .toList(), // Convert the iterable to a list
    );
  }
}

class DailyForecast {
  final String date;
  final double maxTemp;
  final double minTemp;
  final String weatherDescription;

  DailyForecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherDescription,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000) // Convert timestamp to DateTime
          .toIso8601String() // Convert to ISO 8601 string
          .split('T')[0], // Get only the date part
      maxTemp: json['temp']['max'].toDouble(), // Get max temperature
      minTemp: json['temp']['min'].toDouble(), // Get min temperature
      weatherDescription: json['weather'][0]['description'], // Get weather description
    );
  }
}

