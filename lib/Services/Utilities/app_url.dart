class AppUrl {
  // Base URL for the OpenWeatherMap API
  static const String openWeatherBaseUrl = "https://api.openweathermap.org/data/2.5/";

  // Open-Meteo URL for forecast (use coordinates directly)
  static const String openMeteoForecastUrl = "https://api.open-meteo.com/v1/forecast";

  // API key for OpenWeatherMap (replace with your own)
  static const String apiKey = "14dfa869afcd21482222a7e0a94e83dd";

  // Fetch current weather data by city name (OpenWeatherMap)
  static String weatherByCity(String cityName) {
    return "$openWeatherBaseUrl/weather?q=$cityName&appid=$apiKey";
  }


  // Fetch forecast for specific coordinates using Open-Meteo
  static String forecastByCoordinates(double latitude, double longitude) {
    return "$openMeteoForecastUrl?latitude=$latitude&longitude=$longitude&daily=temperature_2m_max,temperature_2m_min&timezone=auto";
  }
}
