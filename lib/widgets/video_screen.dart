import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_gradient/animate_gradient.dart';

class VideoScreen extends StatefulWidget {
  final String? initialVideoAsset; // Make optional to start with playlist

  const VideoScreen({super.key, this.initialVideoAsset});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _controller;
  int _currentVideoIndex = 0;
  bool _isControlsVisible = true;

  // List of all videos in order
  final List<String> _videoAssets = [
    'assets/videos/wagtail_intro3.mp4',
    'assets/videos/wagtail_trump.mp4',
    'assets/videos/wagtail_sad2.mp4',
    'assets/videos/wagtail_intro2.mp4',
    'assets/videos/JCloadingscreen.mp4',
  ];

  @override
  void initState() {
    super.initState();

    // If a specific video is passed, find its index, otherwise start with first video
    if (widget.initialVideoAsset != null) {
      _currentVideoIndex = _videoAssets.indexOf(widget.initialVideoAsset!);
      if (_currentVideoIndex == -1) _currentVideoIndex = 0;
    }

    _initializeVideo();

    // Auto-hide controls after 3 seconds
    _hideControlsTimer();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset(_videoAssets[_currentVideoIndex])
      ..initialize().then((_) {
        setState(() {});
        _controller.play();

        // Listen for video completion to auto-play next video
        _controller.addListener(_videoListener);
      });
  }

  void _videoListener() {
    if (_controller.value.position >= _controller.value.duration) {
      _playNext();
    }
  }

  void _hideControlsTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isControlsVisible = false;
        });
      }
    });
  }

  void _showControls() {
    setState(() {
      _isControlsVisible = true;
    });
    _hideControlsTimer();
  }

  void _playNext() {
    if (_currentVideoIndex < _videoAssets.length - 1) {
      _changeVideo(_currentVideoIndex + 1);
    } else {
      // Loop back to first video
      _changeVideo(0);
    }
  }

  void _playPrevious() {
    if (_currentVideoIndex > 0) {
      _changeVideo(_currentVideoIndex - 1);
    } else {
      // Loop to last video
      _changeVideo(_videoAssets.length - 1);
    }
  }

  void _changeVideo(int newIndex) {
    _controller.removeListener(_videoListener);
    _controller.dispose();

    setState(() {
      _currentVideoIndex = newIndex;
    });

    _initializeVideo();
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player (${_currentVideoIndex + 1}/${_videoAssets.length})'),
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: AnimateGradient(
        primaryColors: const [
          Color(0xFFB993D6), // Purple
          Color(0xFF8CA6DB), // Blue
          Color(0xFFF98CA6), // Pink
        ],
        secondaryColors: const [
          Color(0xFFF5EFA0), // Yellow
          Color(0xFFA6FFD6), // Green
          Color(0xFFF6A6FF), // Light Pink
        ],
        child: GestureDetector(
          onTap: _showControls,
          child: Center(
            child: _controller.value.isInitialized
                ? Stack(
              children: [
                // Video Player
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),

                // Controls Overlay
                if (_isControlsVisible)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Top info bar
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    _videoAssets[_currentVideoIndex]
                                        .split('/')
                                        .last
                                        .replaceAll('.mp4', ''),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Center play controls
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Previous button
                              IconButton(
                                onPressed: _playPrevious,
                                icon: const Icon(
                                  Icons.skip_previous,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),

                              // Play/Pause button
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    } else {
                                      _controller.play();
                                    }
                                  });
                                  _showControls();
                                },
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: 64,
                                ),
                              ),

                              // Next button
                              IconButton(
                                onPressed: _playNext,
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),

                          // Bottom progress bar and time
                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                // Progress slider
                                VideoProgressIndicator(
                                  _controller,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                    playedColor: Colors.white,
                                    bufferedColor: Colors.white54,
                                    backgroundColor: Colors.white24,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Time display
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _formatDuration(_controller.value.position),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _formatDuration(_controller.value.duration),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            )
                : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
