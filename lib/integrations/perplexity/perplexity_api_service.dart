import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aabird/apikeys.dart';

class PerplexityApiService {
  static Future<String> getPromptResponse(String prompt) async {
    if (perplexityApiKey.isEmpty) {
      return 'No API key set. Please set your Perplexity API key in apikeys.dart.';
    }

    final apiUrl = 'https://api.perplexity.ai/your-endpoint'; // update as needed
    final headers = {
      'Authorization': 'Bearer $perplexityApiKey',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'model': 'pro-llm',
      'prompt': prompt,
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? '(No response text)';
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return 'The current API key is invalid or unauthorized.';
      } else {
        return 'API call failed: ${response.statusCode}\n${response.body}';
      }
    } catch (e) {
      return 'Exception during API call: $e';
    }
  }
}
