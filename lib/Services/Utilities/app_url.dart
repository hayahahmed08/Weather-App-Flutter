

class AppUrl {
  //this is our base URL
  // This holds the root of the API URL, making it easy to change if the base changes.
  static const String baseURL = "https://api.openweathermap.org/data/2.5/";
  //End point for fetching weather data by city
  static String getWeatherbyCity(String cityName, String apikey) {
    return "${baseURL}weather?q=$cityName&appid=$apikey";
    //This method takes cityName and apiKey as parameters and constructs the full endpoint URL, making it reusable and flexible for various cities.
  }
}
