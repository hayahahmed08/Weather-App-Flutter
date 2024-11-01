import 'package:flutter/material.dart';
import 'package:weatherapp/Services/weather_services.dart';
import 'package:weatherapp/Model/model_class.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/Model/forecast_model_class.dart';

class WeatherScreen extends StatelessWidget {
  final String cityName;

  WeatherScreen({required this.cityName});

  final Map<String, String> weatherImages = {
    "Thunderstorm": "assets/backgrounds/clear.gif",
    "Drizzle": "assets/backgrounds/clear.gif",
    "Rain": "assets/backgrounds/clear.gif",
    "Snow": "assets/backgrounds/clear.gif",
    "Mist": "assets/backgrounds/clear.gif",
    "Smoke": "assets/backgrounds/clear.gif",
    "Haze": "assets/backgrounds/clear.gif",
    "Dust": "assets/backgrounds/clear.gif",
    "Fog": "assets/backgrounds/clear.gif",
    "Sand": "assets/backgrounds/clear.gif",
    "Ash": "assets/backgrounds/clear.gif",
    "Squall": "assets/backgrounds/clear.gif",
    "Tornado": "assets/backgrounds/clear.gif",
    "Clear": "assets/backgrounds/clear.gif",
    "Clouds": "assets/backgrounds/clear.gif",
  };

  final Map<String, String> weatherIcons = {
    "Thunderstorm": "assets/icons/thunderstorm.png",
    "Drizzle": "assets/icons/drizzle.png",
    "Rain": "assets/icons/drizzle.png",
    "Snow": "assets/icons/snow.png",
    "Mist": "assets/icons/mist.png",
    "Smoke": "assets/icons/mist.png",
    "Haze": "assets/icons/mist.png",
    "Dust": "assets/icons/mist.png",
    "Fog": "assets/icons/mist.png",
    "Sand": "assets/icons/mist.png",
    "Ash": "assets/icons/mist.png",
    "Squall": "assets/icons/squall.png",
    "Tornado": "assets/icons/tornado.png",
    "Clear": "assets/icons/clear.png",
    "Clouds": "assets/icons/clouds.png",
  };

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

            final tempInKelvin = weatherData.main?.temp ?? 0;
            final tempInCelsius = (tempInKelvin - 273).toInt();

            final time = weatherData.timezone ?? 0;
            final now = DateTime.now().toUtc().add(Duration(seconds: time));
            final formattedDate = DateFormat('dd MMM yyyy').format(now);
            final dayName = DateFormat('EEEE').format(now);

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
                      children: [
                        Text(
                          mainWeather!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'UncialAntiqua-Regular',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Image.asset(
                          weatherIcon,
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "${tempInCelsius}°C",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontFamily: 'Roboto-Medium.ttf',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${dayName} | ${formattedDate}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 30),
                        FutureBuilder<Forecast?>(
                          future: weatherServices.fetchForecast(cityName),
                          builder: (context, forecastSnapshot) {
                            if (forecastSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (forecastSnapshot.hasError ||
                                forecastSnapshot.data == null) {
                              return const Text(
                                "Error fetching forecast data",
                                style: TextStyle(color: Colors.white),
                              );
                            } else {
                              final forecastData = forecastSnapshot.data!;
                              return SizedBox(
                                height:
                                    100, // Set height for horizontal list items
                                child: ListView.builder(
                                  scrollDirection:
                                      Axis.horizontal, // Set to horizontal
                                  itemCount: forecastData.list?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final dailyForecast =
                                        forecastData.list![index];
                                    final forecastTempInKelvin =
                                        dailyForecast.main?.temp ?? 0;
                                    final forecastTempInCelsius =
                                        (forecastTempInKelvin - 273).toInt();
                                    final forecastDay =
                                        DateFormat('EEEE').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          dailyForecast.dt! * 1000),
                                    );

                                    return Container(
                                      width: 80, // Set width for each item
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Icon(Icons.wb_sunny,
                                          //     color: Colors.white),
                                          Text(
                                            forecastDay,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "${forecastTempInCelsius}°C",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          },
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
