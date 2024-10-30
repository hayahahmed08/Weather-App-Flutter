import 'package:flutter/material.dart';
import 'package:weatherapp/Services/weather_services.dart';
import 'package:weatherapp/Model/model_class.dart';

class WeatherScreen extends StatelessWidget {
  final String cityName;

  WeatherScreen({required this.cityName});

  @override
  Widget build(BuildContext context) {
    WeatherServices weatherServices = WeatherServices();

    return Scaffold(
      body: FutureBuilder<ModelClass?>(
        future: weatherServices.fetchWeatherByCity(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return const Center(child: Text("Error fetching weather data"));
          } else {
            final weatherData = snapshot.data!;
                       return Stack(
              children: [
                SizedBox.expand(
                  child: Image.asset(
                    'assets/backgrounds/splashscreenbg.gif',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$cityName',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${weatherData.weather![0].main}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}


final Map<String, String> weatherImages = {
  "Thunderstorm": "assets/backgrounds/thunderstorm.gif",
  "Drizzle": "assets/backgrounds/drizzle.gif",
  "Rain": "assets/backgrounds/rain.gif",
  "Snow": "assets/images/snow.png",
  "Mist": "assets/backgrounds/mist.gif",
  "Smoke": "assets/backgrounds/mist.gif",
  "Haze": "assets/backgrounds/mist.gif",
  "Dust": "assets/images/dust.png",
  "Fog": "assets/images/fog.png",
  "Sand": "assets/images/sand.png",
  "Ash": "assets/images/ash.png",
  "Squall": "assets/images/squall.png",
  "Tornado": "assets/images/tornado.png",
  "Clear": "assets/images/clear.png",
  "Clouds": "assets/images/clouds.png",
};