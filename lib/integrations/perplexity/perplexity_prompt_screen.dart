import 'package:flutter/material.dart';
import 'perplexity_api_service.dart'; // same folder, use relative path

class PerplexityPromptScreen extends StatefulWidget {
  const PerplexityPromptScreen({super.key});

  @override
  State<PerplexityPromptScreen> createState() => _PerplexityPromptScreenState();
}

class _PerplexityPromptScreenState extends State<PerplexityPromptScreen> {
  String result = 'Loading...';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPromptResponse();
  }

  Future<void> fetchPromptResponse() async {
    const prompt = 'What is a wagtail bird?'; // Hardcoded for now
    final response = await PerplexityApiService.getPromptResponse(prompt);
    setState(() {
      result = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perplexity Result'),
        leading: BackButton(),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(20),
          child: Text(result),
        ),
      ),
    );
  }
}