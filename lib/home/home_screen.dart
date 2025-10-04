import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  Color _backgroundColor = Colors.purple[50]!; // initial color (matches screenshot)
  final AudioPlayer _player = AudioPlayer();
  final Random _random = Random();

  void _onIconTap() async {
    setState(() {
      _counter++;
    });
    await _player.play(AssetSource('audio/wagtail-chirp4.mp3'));
  }

  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _onIconTap,
                child: Image.asset(
                  'assets/images/wagtail_icon.png',
                  width: 120,
                  height: 120,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Welcome to AAbird Home Screen!'),
              const SizedBox(height: 24),
              Text('You have pushed the bird this many times:'),
              Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeBackgroundColor,
        tooltip: 'Change background',
        child: const Icon(Icons.add),
      ),
    );
  }
}
