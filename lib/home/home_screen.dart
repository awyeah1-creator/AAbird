import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
// Make sure the path is correct for your project layout!
import '../widgets/video_screen.dart';
import 'package:aabird/integrations/perplexity/perplexity_prompt_screen.dart';
import 'package:aabird/integrations/perplexity/wagtail_fact_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  Color _backgroundColor = Colors.purple[50]!;
  final AudioPlayer _player = AudioPlayer();
  final Random _random = Random();

  final List<String> wagtailImages = [
    'assets/images/wagtail_epic.png',
    'assets/images/wagtail_river.png',
    'assets/images/wagtail_sunflower.png',
    'assets/images/wagtail_gold.png',
  ];

  void _onIconTap() async {
    setState(() {
      _counter++;
    });
    await _player.play(AssetSource('audio/wagtail-chirp4.mp3'));
  }

  void _onGridIconTap(int index) async {
    setState(() {
      _counter++;
    });
    if (wagtailImages[index].contains('wagtail_gold.png')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              VideoScreen(videoAsset: 'assets/videos/JCloadingscreen.mp4'),
        ),
      );
      return;
    }
    if (wagtailImages[index].contains('wagtail_river.png')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const WagtailFactScreen(),
        ),
      );
      return;
    }
    if (wagtailImages[index].contains('wagtail_epic.png')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PerplexityPromptScreen(),
        ),
      );
      return;
    }
    // Optional: Play sound for all icons if you want
    // await _player.play(AssetSource('audio/wagtail-chirp4.mp3'));
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
    final int crossAxisCount =
    (MediaQuery.of(context).size.width ~/ 140).clamp(2, 4);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: SingleChildScrollView(
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
                Text('$_counter',
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: wagtailImages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onGridIconTap(index),
                        child: Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            wagtailImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
