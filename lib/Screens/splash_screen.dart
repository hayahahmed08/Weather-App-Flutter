import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              // Background image with decreased opacity
              Positioned.fill(
                child: Opacity(
                  opacity: 1,
                  child: Image(
                    image: AssetImage('assets/backgrounds/splashscreenbg.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Foreground text
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'we', // First part of the text
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
