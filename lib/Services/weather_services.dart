import 'package:http/http.dart' as http;
import 'package:weatherapp/Services/Utilities/app_url.dart';
import 'package:weatherapp/Model/model_class.dart';
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
}
