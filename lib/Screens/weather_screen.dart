import 'package:flutter/material.dart';
import 'package:weatherapp/Services/weather_services.dart';
import 'package:weatherapp/Model/model_class.dart';
import 'package:intl/intl.dart';
im

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

            final tempInKelvin = weatherData.main?.temp ?? 0;
            final tempInCelsius = (tempInKelvin - 273).toInt();

            final time = weatherData.timezone ?? 0;
            final now = DateTime.now().toUtc().add(Duration(seconds: time));
            final formattedDate = DateFormat('dd MMM yyyy').format(now);
            final dayName = DateFormat('EEEE').format(now);

            // Generate the dates for the next 5 days
            List<DateTime> nextFiveDays = [
              now.add(Duration(days: 1)),
              now.add(Duration(days: 2)),
              now.add(Duration(days: 3)),
              now.add(Duration(days: 4)),
              now.add(Duration(days: 5)),
            ];

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

                      ],
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: nextFiveDays.length,
                  itemBuilder: (BuildContext context , int index){
                    DateTime day = nextFiveDays[index];
                    String dayName = DateFormat('EEE').format(day);

                    return Container(


                    )
                  },
                )
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
