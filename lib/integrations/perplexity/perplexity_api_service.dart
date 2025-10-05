import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aabird/apikeys.dart';

class PerplexityApiService {
  // Change this to the correct Perplexity API endpoint!
  static const String apiUrl = 'https://api.perplexity.ai/chat/completions'; // update as needed

  static Future<String> getPromptResponse(String prompt) async {
    if (perplexityApiKey.isEmpty) {
      print('[PerplexityApiService] ERROR: No API key set.');
      return 'No API key set. Please set your Perplexity API key in apikeys.dart.';
    }

    final headers = {
      'Authorization': 'Bearer $perplexityApiKey',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'model': 'sonar-pro', // Check model name against Perplexity docs
      'messages': [
        {'role': 'user', 'content': prompt}
      ],
    });

    // Log the outgoing request for debugging
    print('[PerplexityApiService] Sending POST $apiUrl');
    print('[PerplexityApiService] Headers: $headers');
    print('[PerplexityApiService] Body: $body');

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      print('[PerplexityApiService] Response status: ${response.statusCode}');
      print('[PerplexityApiService] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final output = data['choices']?[0]?['message']?['content'] ?? data['response'] ?? '(No response text)';
        print('[PerplexityApiService] Parsed output: $output');
        return output;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        print('[PerplexityApiService] ERROR: Unauthorized. Check API key.');
        return 'The current API key is invalid or unauthorized.';
      } else if (response.statusCode == 404) {
        print('[PerplexityApiService] ERROR: Endpoint not found (404). Double-check apiUrl!');
        return 'API endpoint not found (404). Please check your apiUrl.';
      } else {
        print('[PerplexityApiService] ERROR: API call failed with code ${response.statusCode}');
        return 'API call failed: ${response.statusCode}\n${response.body}';
      }
    } catch (e, stack) {
      print('[PerplexityApiService] EXCEPTION: $e\n$stack');
      return 'Exception during API call: $e';
    }
  }
}
