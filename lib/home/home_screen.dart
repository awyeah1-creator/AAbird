import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AAbird Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to AAbird!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
