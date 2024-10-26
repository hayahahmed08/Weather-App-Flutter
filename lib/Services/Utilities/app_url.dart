class AppUrl {
  // Base URL for the OpenWeatherMap API
  static const String baseUrl = "https://api.openweathermap.org/data/2.5/";

  // Replace {cityName} with the city name of your choice and add your actual API key here
  static const String apiKey = "14dfa869afcd21482222a7e0a94e83dd";

  // Fetch weather data by city name
  static String weatherByCity(String cityName) {
    return "$baseUrl/weather?q=$cityName&appid=$apiKey";
  }
}
