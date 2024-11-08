import 'package:flutter/material.dart';
import 'package:weatherapp/Model/forecast_model_class.dart';
import 'package:weatherapp/Services/weather_services.dart';
import 'package:weatherapp/Model/model_class.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

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

            final day1 = DateFormat('EEE').format(now.add(Duration(days: 1)));
            final day2 = DateFormat('EEE').format(now.add(Duration(days: 2)));
            final day3 = DateFormat('EEE').format(now.add(Duration(days: 3)));
            final day4 = DateFormat('EEE').format(now.add(Duration(days: 4)));
            final day5 = DateFormat('EEE').format(now.add(Duration(days: 5)));

            final temp1 = tempInCelsius + 1;
            final temp2 = tempInCelsius;
            final temp3 = tempInCelsius + 2;
            final temp4 = tempInCelsius + 1;
            final temp5 = tempInCelsius + 4;

            final Map<String, int> forecastTemperatures = {
              day1: temp1,
              day2: temp2,
              day3: temp3,
              day4: temp4,
              day5: temp5,
            };

            final Map<String, String> forecastIcons = {
              day1: "assets/icons/clear.png",
              day2: "assets/icons/clear.png",
              day3: "assets/icons/mist.png",
              day4: "assets/icons/mist.png",
              day5: "assets/icons/clouds.png",
            };

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
                          "$dayName | $formattedDate",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Forecast for next 5 days",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          height: 120, // Fixed height for the list
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: forecastTemperatures.length,
                                itemBuilder: (context, index) {
                                  // Get the day and temperature from the map
                                  String day =
                                  forecastTemperatures.keys.elementAt(index);
                                  int temp = forecastTemperatures[day]!;
                                  String iconPath = forecastIcons[day]!;

                                  return Container(
                                    width: 70, // Width for each item
                                    margin:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          day,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Image.asset(
                                          iconPath,
                                          height: 40,
                                          width: 40,
                                        ),
                                        Text(
                                          '$temp°C',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),

                                      ],

                                    ),

                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Space between sections

                        // Four additional glassmorphic containers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Center(
                                    child: Text(
                                      "Info ${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
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

// Expanded(
                        //   child:FutureBuilder<Forecast?>(
                        //     future: weatherServices.fetchForecast(
                        //         weatherData.coord?.lat ?? 0.0, // Default to 0.0 if lat is null
                        //         weatherData.coord?.lon ?? 0.0  // Default to 0.0 if lon is null
                        //     ),
                        //     builder: (context, snapshot) {
                        //       if (snapshot.connectionState == ConnectionState.waiting) {
                        //         return Center(child: CircularProgressIndicator());
                        //       } else if (snapshot.hasError) {
                        //         return Center(child: Text("Error: ${snapshot.error}"));
                        //       } else if (!snapshot.hasData || snapshot.data == null) {
                        //         return Center(child: Text("No forecast data available"));
                        //       } else {
                        //         final forecastData = snapshot.data!;
                        //         return ListView.builder(
                        //           itemCount: forecastData.daily.length,
                        //           itemBuilder: (context, index) {
                        //             return ListTile(
                        //               title: Text(forecastData.daily[index].date),
                        //               subtitle: Text("Max Temp: ${forecastData.daily[index].maxTemp}°C"),
                        //             );
                        //           },
                        //         );
                        //       }
                        //     },
                        //   )
                        //
                        // )
