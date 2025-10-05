import 'package:flutter/material.dart';
import 'wagtail_fact_widget.dart';

class WagtailFactScreen extends StatelessWidget {
  const WagtailFactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wagtail Fun Fact'),
        leading: BackButton(),
      ),
      body: Center(
        child: WagtailFactWidget(), // The fact widget inside a responsive layout
      ),
    );
  }
}
