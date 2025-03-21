import 'package:flutter/material.dart';
import '../../../widgets/custom_app_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieWatchScreen extends StatefulWidget {
  final dynamic movie;

  MovieWatchScreen({required this.movie});

  @override
  _MovieWatchScreenState createState() => _MovieWatchScreenState();
}

class _MovieWatchScreenState extends State<MovieWatchScreen> {
  late YoutubePlayerController _controller;
  String? videoId;
  bool isControlsVisible = true;

  @override
  void initState() {
    super.initState();

    final videoUrl = widget.movie['video'];
    videoId = YoutubePlayer.convertUrlToId(videoUrl);

    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          loop: false,
          enableCaption: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleControls() {
    setState(() {
      isControlsVisible = !isControlsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(title: widget.movie['title']),
      body: videoId != null
          ? Stack(
              children: [
                GestureDetector(
                  onTap: toggleControls,
                  child: YoutubePlayerBuilder(
                    player: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                    ),
                    builder: (context, player) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: player,
                      );
                    },
                  ),
                ),
                if (isControlsVisible)
                  Positioned(
                    top: 40,
                    left: 10,
                    right: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     
                    ),
                  ),
              ],
            )
          : Center(
              child: Text(
                "Error: Invalid YouTube video URL",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
    );
  }
}
