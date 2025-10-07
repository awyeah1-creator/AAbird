import 'package:flutter/material.dart';
// Update these with your actual paths
import 'perplexity_api_service.dart';
import '../../services/voice_service.dart';

class PerplexityPromptScreen extends StatefulWidget {
  const PerplexityPromptScreen({super.key});

  @override
  State<PerplexityPromptScreen> createState() => _PerplexityPromptScreenState();
}

class _PerplexityPromptScreenState extends State<PerplexityPromptScreen> {
  final TextEditingController _textController = TextEditingController();
  String result = '';
  bool isLoading = false;
  bool isListening = false;
  bool voiceReady = false;

  @override
  void initState() {
    super.initState();
    _initVoiceService();
  }

  Future<void> _initVoiceService() async {
    voiceReady = await VoiceService.initialize();
    setState(() {});
  }

  // Option 1: Manual Text Submission
  Future<void> _submitText() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      isLoading = true;
      result = '';
    });
    final response = await PerplexityApiService.getPromptResponse(text);
    setState(() {
      isLoading = false;
      result = response;
    });
  }

  // Option 2: Voice Submission
  Future<void> _startListening() async {
    if (!voiceReady || isListening) return;
    setState(() {
      isListening = true;
    });
    final spoken = await VoiceService.listenForSpeech();
    setState(() {
      isListening = false;
    });
    if (spoken != null && spoken.isNotEmpty) {
      _textController.text = spoken;
      // Optionally submit automatically
      await _submitText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perplexity Prompt'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Option 1: Text input and submit button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitText,
                  child: const Icon(Icons.send),
                ),
                const SizedBox(width: 8),
                // Option 2: Microphone button for voice input
                IconButton(
                  icon: Icon(isListening ? Icons.mic : Icons.mic_none),
                  color: voiceReady ? Colors.blue : Colors.grey,
                  onPressed: voiceReady ? _startListening : null,
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else
              Card(
                margin: const EdgeInsets.only(top: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    result.isNotEmpty ? result : 'Enter text or tap mic to ask!',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    VoiceService.stopListening();
    super.dispose();
  }
}
