import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieWatchScreen extends StatefulWidget {
  final dynamic movie;  // This will hold the data of the movie passed from the previous screen.

  MovieWatchScreen({required this.movie});

  @override
  _MovieWatchScreenState createState() => _MovieWatchScreenState();
}

class _MovieWatchScreenState extends State<MovieWatchScreen> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();

    // Ensure the 'video' URL is valid and extract the YouTube video ID
    if (widget.movie['video'] != null && widget.movie['video'] is String) {
      final videoUrl = widget.movie['video'];
      final videoId = YoutubePlayer.convertUrlToId(videoUrl);

      if (videoId != null) {
        // Initialize the YouTube player controller
        _controller = YoutubePlayerController(
          initialVideoId: videoId,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
            loop: true,
          ),
        );
      } else {
        throw Exception("Video URL is invalid or missing.");
      }
    } else {
      throw Exception("Video URL is invalid or missing.");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Fullscreen mode toggle function
  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null // Hide AppBar when in full screen
          : AppBar(
              title: Text(widget.movie['title']),
            ),
      body: GestureDetector(
        onTap: _toggleFullScreen, // Toggle full-screen on tap
        child: Center(
          child: Stack(
            children: [
              // Full-screen video player
              Positioned.fill(
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                  onReady: () {},
                ),
              ),
              // If not full screen, show the movie info on top
              if (!_isFullScreen)
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie['title'],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.movie['genre'],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              // Full-screen toggle button
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleFullScreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
