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
            final mainWeather = weatherData.weather![0].main;

            final backgroundImage =
                weatherImages[mainWeather] ?? 'assets/backgrounds/clear.gif';

            final weatherIcon =
                weatherIcons[mainWeather] ?? 'assets/icons/tornado.png';

            return Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                  child: SizedBox.expand(
                    child: Image.asset(
                      backgroundImage,
                                         fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        cityName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'UncialAntiqua-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mainWeather!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          //  fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          weatherIcon,
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Temperature: ${weatherData.main?.temp}°C",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
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
  "Snow": "assets/backgrounds/snow.gif",
  "Mist": "assets/backgrounds/mist.gif",
  "Smoke": "assets/backgrounds/smoke.gif",
  "Haze": "assets/backgrounds/haze.gif",
  "Dust": "assets/backgrounds/dust.gif",
  "Fog": "assets/backgrounds/fog.gif",
  "Sand": "assets/backgrounds/sand.gif",
  "Ash": "assets/backgrounds/ash.gif",
  "Squall": "assets/backgrounds/squall.gif",
  "Tornado": "assets/backgrounds/tornado.gif",
  "Clear": "assets/backgrounds/clear.gif",
  "Clouds": "assets/backgrounds/clouds.gif",
};

final Map<String, String> weatherIcons = {
  "Thunderstorm": "assets/icons/thunderstorm.png",
  "Drizzle": "assets/icons/drizzle.png",
  "Rain": "assets/icons/rain.png",
  "Snow": "assets/icons/snow.png",
  "Mist": "assets/icons/mist.png",
  "Smoke": "assets/icons/smoke.png",
  "Haze": "assets/icons/haze.png",
  "Dust": "assets/icons/dust.png",
  "Fog": "assets/icons/fog.png",
  "Sand": "assets/icons/sand.png",
  "Ash": "assets/icons/ash.png",
  "Squall": "assets/icons/squall.png",
  "Tornado": "assets/icons/tornado.png",
  "Clear": "assets/icons/clear.png",
  "Clouds": "assets/icons/clouds.png",
};
