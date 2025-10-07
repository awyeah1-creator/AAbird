import 'package:flutter/material.dart';
import 'perplexity_api_service.dart';
import '../../services/voice_service.dart';
import '../../services/database_service.dart';

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
  bool isVoiceEnabled = false;
  List<Map<String, dynamic>> chatHistory = [];

  @override
  void initState() {
    super.initState();
    _initializeVoice();
    _loadChatHistory();
  }

  Future<void> _initializeVoice() async {
    final success = await VoiceService.initialize();
    setState(() {
      isVoiceEnabled = success;
    });
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Voice features not available')),
      );
    }
  }

  Future<void> _loadChatHistory() async {
    final history = await DatabaseService.getChatHistory();
    setState(() {
      chatHistory = history;
    });
  }

  Future<void> _startListening() async {
    if (!isVoiceEnabled) return;

    setState(() {
      isListening = true;
    });

    final recognizedText = await VoiceService.listenForSpeech();

    setState(() {
      isListening = false;
    });

    if (recognizedText != null && recognizedText.isNotEmpty) {
      _textController.text = recognizedText;
      // Automatically submit the query
      _submitQuery(recognizedText);
    }
  }

  Future<void> _submitQuery(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
      result = '';
    });

    try {
      final response = await PerplexityApiService.getPromptResponse(query);

      // Save to local storage
      await DatabaseService.saveChatHistory(query, response);

      setState(() {
        result = response;
        isLoading = false;
      });

      // Speak the response if voice is enabled
      if (isVoiceEnabled) {
        await VoiceService.speak(response);
      }

      // Refresh chat history
      _loadChatHistory();

    } catch (e) {
      setState(() {
        result = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice-Enabled Perplexity'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _showHistoryDialog(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input section
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _submitQuery,
                  ),
                ),
                SizedBox(width: 8),
                // Voice input button
                FloatingActionButton(
                  mini: true,
                  onPressed: isVoiceEnabled ? _startListening : null,
                  backgroundColor: isListening ? Colors.red : Colors.blue,
                  child: Icon(
                    isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 8),
                // Submit button
                FloatingActionButton(
                  mini: true,
                  onPressed: () => _submitQuery(_textController.text),
                  child: Icon(Icons.send),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Status indicators
            if (isListening)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.mic, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Listening...', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ),

            // Response section
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : result.isNotEmpty
                  ? Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(result),
                  ),
                ),
              )
                  : Center(
                child: Text(
                  'Ask a question using voice or text!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Chat History'),
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: chatHistory.length,
            itemBuilder: (context, index) {
              final item = chatHistory[index];
              return Card(
                child: ListTile(
                  title: Text(
                    item['query'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    item['response'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      result = item['response'];
                      _textController.text = item['query'];
                    });
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    VoiceService.stopListening();
    VoiceService.stopSpeaking();
    _textController.dispose();
    super.dispose();
  }
}
