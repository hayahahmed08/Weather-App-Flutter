import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weatherapp/Services/weather_services.dart';
import 'package:weatherapp/Screens/weather_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController searchController = TextEditingController();
  List<String> citylist = [];
  List<String> filteredlist = [];

  @override
  void initState() {
    super.initState();
    loadCities();
  }

  void loadCities() async {
    WeatherServices weatherServices = WeatherServices();
    try {
      List<String> cities = await weatherServices.loadCities();
      setState(() {
        citylist = cities;
        filteredlist = [];
      });
    } catch (e) {
      print("Error loading cities: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  'assets/backgrounds/splashscreenbg.gif',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: 'we',
                        style: TextStyle(
                          fontSize: 60,
                          fontFamily: 'Serif',
                          color: Colors.white,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '  ther\n',
                            style: TextStyle(
                              fontSize: 55,
                              fontFamily: 'Serif',
                            ),
                          ),
                          TextSpan(
                            text: ' \t\tA',
                            style: TextStyle(
                              fontSize: 90,
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF763645),
                            ),
                          ),
                          TextSpan(
                            text: 'pp\n',
                            style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'Serif',
                            ),
                          ),
                        ],
                      ),
                      strutStyle: StrutStyle(
                        fontFamily: 'Serif',
                        fontSize: 30,
                        forceStrutHeight: true,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          hintText: 'Search city',
                          hintStyle: TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white70),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        onChanged: (value) {
                          setState(() {
                            filteredlist = value.isEmpty
                                ? []
                                : citylist
                                    .where((city) => city
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    if (filteredlist.isNotEmpty)
                      Container(
                        height: 260,
                        width: 300,
                        child: ListView.builder(
                          itemCount: filteredlist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(0.3),
                              ),
                              child: ListTile(
                                dense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                title: Text(
                                  filteredlist[index],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherScreen()),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 10,
                              sigmaY: 10,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF763645).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Serif",
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
