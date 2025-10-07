import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceService {
  static final SpeechToText _speechToText = SpeechToText();
  static final FlutterTts _flutterTts = FlutterTts();
  static bool _isListening = false;

  static Future<bool> initialize() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return false;
    }

    // Initialize speech to text
    bool available = await _speechToText.initialize(
      onError: (error) => print('Speech recognition error: $error'),
      onStatus: (status) => print('Speech recognition status: $status'),
    );

    // Initialize TTS
    await _flutterTts.setLanguage('en-AU'); // Australian English
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);

    return available;
  }

  static Future<String?> listenForSpeech() async {
    if (!_speechToText.isAvailable) return null;

    String recognizedWords = '';

    await _speechToText.listen(
      onResult: (result) {
        recognizedWords = result.recognizedWords;
      },
      listenFor: Duration(seconds: 30),
      pauseFor: Duration(seconds: 3),
    );

    return recognizedWords.isNotEmpty ? recognizedWords : null;
  }

  static Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  static Future<void> stopListening() async {
    await _speechToText.stop();
  }

  static Future<void> stopSpeaking() async {
    await _flutterTts.stop();
  }

  static bool get isListening => _speechToText.isListening;
}
