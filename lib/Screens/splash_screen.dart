import 'package:flutter/material.dart';
import 'package:weatherapp/Services/weather_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  TextEditingController searchController = TextEditingController();
  List<dynamic> citylist = [];
  List<dynamic> filteredlist = [];

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
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 20), // Space between text and search box
                  Container(
                    width: 300, // Set width as needed
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                        hintText: 'Search with city ',
                        hintStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        setState(() {
                          filteredlist = citylist
                              .where((city) => city['city']
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
