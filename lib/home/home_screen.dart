import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  final AudioPlayer _player = AudioPlayer();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _playChirp() async {
    await _player.play(AssetSource('audio/wagtail-chirp4.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _playChirp,
              child: Image.asset(
                'assets/images/wagtail_icon.png',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Welcome to AAbird Home Screen!'),
            const SizedBox(height: 24),
            Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
