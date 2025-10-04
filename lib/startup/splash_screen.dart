import 'dart:async';
import 'package:flutter/material.dart';
import 'package:aabird/home/home_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        // broken MaterialPageRoute(builder: (_) => HomeScreen()),
        MaterialPageRoute(builder: (_) => HomeScreen(title: 'AAbird Home')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // You can customize
      body: Center(
        child: Text(
          'AAbird',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
