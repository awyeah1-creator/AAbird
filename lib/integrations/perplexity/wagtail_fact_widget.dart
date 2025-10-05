import 'package:flutter/material.dart';
import 'perplexity_api_service.dart'; // Update import path if needed
import 'wagtail_prompts.dart';        // Your prompt file

class WagtailFactWidget extends StatefulWidget {
  const WagtailFactWidget({super.key});

  @override
  State<WagtailFactWidget> createState() => _WagtailFactWidgetState();
}

class _WagtailFactWidgetState extends State<WagtailFactWidget> {
  String _fact = '';
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    fetchFact();
  }

  Future<void> fetchFact() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final prompt = wagtailFactPrompt(); // From wagtail_prompts.dart
      final response = await PerplexityApiService.getPromptResponse(prompt);

      setState(() {
        _fact = response ?? '(No fact returned)';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load fact: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.yellow[50],
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _error != null
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: TextStyle(color: Colors.red, fontSize: 16)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: fetchFact,
              child: const Text('Try again'),
            ),
          ],
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _fact,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: fetchFact,
              icon: Icon(Icons.refresh),
              label: const Text('Get another fact'),
            ),
          ],
        ),
      ),
    );
  }
}
