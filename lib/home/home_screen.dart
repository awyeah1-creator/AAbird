import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import '../widgets/video_screen.dart';
import 'package:aabird/integrations/perplexity/wagtail_fact_screen.dart';
import 'package:aabird/integrations/perplexity/wagtail_openquery_widget.dart';
import 'package:aabird/integrations/perplexity/wagtail_prompts.dart'; // ensure this imports openFactPrompt, rsmFactPrompt

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  final AudioPlayer _player = AudioPlayer();
  final Random _random = Random();

  final List<String> wagtailImages = [
    'assets/images/wagtail_facts.png',
    'assets/images/wagtail_pplx.png',
    'assets/images/wagtail_rsm.png',
    'assets/images/wagtail_tv.png',
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
    await _player.play(AssetSource('audio/wagtail-chirp4.mp3'));
    if (wagtailImages[index].contains('wagtail_tv.png')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              // VideoScreen(videoAsset: 'assets/videos/JCloadingscreen.mp4'),
              VideoScreen(),
        ),
      );
      return;
    }
    if (wagtailImages[index].contains('wagtail_facts.png')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const WagtailFactScreen(),
        ),
      );
      return;
    }
    if (wagtailImages[index].contains('wagtail_rsm.png')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WagtailOpenQueryWidget(
            promptFn: rsmFactPrompt,
            topic: "RSM Australia",
          ),
        ),
      );
      return;
    }
    if (wagtailImages[index].contains('wagtail_pplx.png')) {
      final extraContext = await showDialog<String>(
        context: context,
        builder: (context) {
          String input = "";
          return AlertDialog(
            title: Text('Enter a topic for your Perth fun fact'),
            content: TextField(
              autofocus: true,
              onChanged: (value) {
                input = value;
              },
              decoration: InputDecoration(hintText: "e.g. parrot, weather, city council"),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, input),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      if (extraContext != null && extraContext.trim().isNotEmpty) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WagtailOpenQueryWidget(
              promptFn: openFactPrompt,
              topic: extraContext.trim(),
            ),
          ),
        );
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = (MediaQuery.of(context).size.width ~/ 140).clamp(2, 4);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: AnimateGradient(
        primaryColors: const [
          Color(0xFFB993D6), // Purple
          Color(0xFF8CA6DB), // Blue
          Color(0xFFF98CA6), // Pink
        ],
        secondaryColors: const [
          Color(0xFFF5EFA0), // Yellow
          Color(0xFFA6FFD6), // Green
          Color(0xFFF6A6FF), // Light Pink
        ],
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
        onPressed: () {
          setState(() {});
        },
        tooltip: 'Change background',
        child: const Icon(Icons.add),
      ),
    );
  }
}
