import 'package:http/http.dart' as http;
import 'package:weatherapp/Services/Utilities/app_url.dart';
import 'package:weatherapp/Model/model_class.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert';
import 'package:weatherapp/Model/forecast_model_class.dart';

class WeatherServices {
  // Fetch current weather data by city name
  Future<ModelClass> fetchWeatherByCity(String cityName) async {
    final response = await http.get(Uri.parse(AppUrl.weatherByCity(cityName)));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ModelClass.fromJson(data);
    } else {
      throw Exception('Error: Failed to load weather data');
    }
  }

  //no longer displaying real time data as openweatherapi isnt working
  // // Fetch forecast data by latitude and longitude
  // Future<Forecast> fetchForecast(double lat, double lon) async {
  //   final response = await http.get(
  //     Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=14dfa869afcd21482222a7e0a94e83dd&units=metric'),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return Forecast.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load forecast');
  //   }
  // }


  // Load list of city names from a JSON file in assets
  Future<List<String>> loadCities() async {
    try {
      final String response = await rootBundle.loadString('assets/cities.json');
      final data = json.decode(response);
      return List<String>.from(data.map((city) => city['name']));
    } catch (e) {
      print("Error loading cities: $e");
      return [];
    }
  }
}
