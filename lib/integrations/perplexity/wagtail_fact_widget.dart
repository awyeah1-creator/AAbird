import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart'; // For clipboard
import 'perplexity_api_service.dart';
import 'wagtail_prompts.dart';
import 'package:auto_size_text/auto_size_text.dart';


class WagtailFactWidget extends StatefulWidget {
  const WagtailFactWidget({super.key});

  @override
  State<WagtailFactWidget> createState() => _WagtailFactWidgetState();
}

class _WagtailFactWidgetState extends State<WagtailFactWidget> with SingleTickerProviderStateMixin {
  String _fact = '';
  bool _isLoading = false;
  String? _error;
  late AnimationController _controller;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _bounce = Tween<double>(begin: 0, end: 10).chain(CurveTween(curve: Curves.elasticInOut))
        .animate(_controller);

    fetchFact();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchFact() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final prompt = wagtailFactPrompt(); // Ensure prompt says "no reference marks"
      final response = await PerplexityApiService.getPromptResponse(prompt);

      setState(() {
        _fact = response;
        _isLoading = false;
      });

      // Start the bounce animation
      _controller.forward(from: 0.0);
    } catch (e) {
      setState(() {
        _error = 'Failed to load fact: $e';
        _isLoading = false;
      });
    }
  }

  void _copyFact() async {
    if (_fact.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: _fact));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fact copied!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gradient background for page
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.deepOrange.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(16),
          color: Colors.orange[50],
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.62,
                minWidth: double.infinity,
              ),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _error != null
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  Text(_error!, style: GoogleFonts.nunito(color: Colors.red, fontSize: 16)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange[400],
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
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
                    // Did you know? chip
                    Chip(
                      label: Text(
                        'Did you know?',
                        style: GoogleFonts.fredoka(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Colors.deepOrange[100],
                    ),
                    const SizedBox(height: 8),
                    // Animated Wagtail image
                    AnimatedBuilder(
                      animation: _bounce,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_bounce.value),
                          child: child,
                        );
                      },
                      child: Image.asset("assets/images/wagtail_icon.png", height: 54),
                    ),
                    const SizedBox(height: 16),
                    AutoSizeText(
                      _fact,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 22,
                        height: 1.36,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                      minFontSize: 14,
                      overflow: TextOverflow.visible, // Ensures full text display
                    )
                    ,

                    const SizedBox(height: 24),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange[400],
                            foregroundColor: Colors.white,
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: fetchFact,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Get another fact'),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: _copyFact,
                          icon: const Icon(Icons.copy, color: Colors.deepOrange, size: 32),
                          tooltip: "Copy fact",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
