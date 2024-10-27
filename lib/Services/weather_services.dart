import 'package:http/http.dart' as http;
import 'package:weatherapp/Services/Utilities/app_url.dart';
import 'package:weatherapp/Model/model_class.dart';
import 'package:flutter/services.dart'; // Added for rootBundle
import 'dart:convert';

class WeatherServices {

  // Fetch weather data by city name
  Future<ModelClass> fetchWeatherByCity(String cityName) async {
    final response = await http.get(Uri.parse(AppUrl.weatherByCity(cityName)));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ModelClass.fromJson(data);
    } else {
      throw Exception('Error: Failed to load weather data');
    }
  }

  // Load list of city names from JSON file
  Future<List<String>> loadCities() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    final data = await json.decode(response);
    return List<String>.from(data.map((city) => city['name']));
  }
}
