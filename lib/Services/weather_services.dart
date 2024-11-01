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

  // Fetch forecast data by city name
  Future<Forecast> fetchForecast(String cityName) async {
    final response = await http.get(Uri.parse(AppUrl.forecastbyCity(cityName)));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Forecast.fromJson(data);
    } else {
      throw Exception('Error: Failed to load forecast data');
    }
  }

  // Load list of city names from a JSON file in assets
  Future<List<String>> loadCities() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final data = json.decode(response);
    return List<String>.from(data.map((city) => city['name']));
  }
}