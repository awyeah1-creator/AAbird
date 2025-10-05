import 'package:flutter/material.dart';
// import 'package:aabird/integrations/perplexity/wagtail_fact_widget.dart';
import 'package:aabird/integrations/perplexity/wagtail_prompts.dart'; // Make sure prompt function is here!
import 'package:aabird/integrations/perplexity/wagtail_openquery_widget.dart';

class WagtailTriviaScreen extends StatelessWidget {
  const WagtailTriviaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wagtail Trivia')),
      body: Center(
        child: WagtailOpenQueryWidget(promptFn: wagtailFactPrompt), // Any prompt function
      ),
    );
  }
}

class HomeScreenV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AWYEAH', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Main content area
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Welcome to the App!@',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          // Navigation or action buttons
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WagtailOpenQueryWidget(promptFn: rsmFactPrompt)),
                    );
                  },
                  child: Text('Wagtail tip'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Feature 2'),
                )
              ],
            ),
          ),
          // Banner ad space (e.g., 320x50)
          Container(
            width: double.infinity,
            height: 50,  // Typical height for AdMob banner
            color: Colors.grey[200], // Placeholder background
            child: Center(
              child: Text(
                'Banner Ad Space (320x50)',
                style: TextStyle(color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
