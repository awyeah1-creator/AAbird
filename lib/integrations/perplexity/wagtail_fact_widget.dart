import 'package:flutter/material.dart';
import 'perplexity_api_service.dart';
import 'wagtail_prompts.dart';

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
      final prompt = wagtailFactPrompt();
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
      margin: const EdgeInsets.all(18),
      color: Colors.orange[50],
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.55,
            minWidth: double.infinity,
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : _error != null
              ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Colors.red, fontSize: 16)),
              const SizedBox(height: 18),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange[400],
                  foregroundColor: Colors.white,
                  shape: StadiumBorder(),
                ),
                onPressed: fetchFact,
                child: const Text('Try again'),
              ),
            ],
          )
              : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset("assets/images/wagtail_icon.png", height: 48),
                const SizedBox(height: 10),
                Text(
                  _fact,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
                const SizedBox(height: 28),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange[400],
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                    shape: StadiumBorder(),
                  ),
                  onPressed: fetchFact,
                  icon: Icon(Icons.refresh),
                  label: const Text('Get another fact'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
