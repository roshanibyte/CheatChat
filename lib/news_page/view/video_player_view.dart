import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeUrlPlayer extends StatefulWidget {
  @override
  _YoutubeUrlPlayerState createState() => _YoutubeUrlPlayerState();
}

class _YoutubeUrlPlayerState extends State<YoutubeUrlPlayer> {
  final TextEditingController _controller = TextEditingController();
  YoutubePlayerController? _youtubeController;
  String? _videoId;

  void _loadYouTubeVideo() {
    String url = _controller.text;
    if (YoutubePlayer.convertUrlToId(url) != null) {
      setState(() {
        _videoId = YoutubePlayer.convertUrlToId(url);
        _youtubeController = YoutubePlayerController(
          initialVideoId: _videoId!,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid YouTube URL')),
      );
    }
  }

  late VideoPlayerController _videoPlayercontroller;

  @override
  void initState() {
    super.initState();
    _videoPlayercontroller =
        VideoPlayerController.asset("assets/animals/grizzy_video.mp4")
          ..initialize().then((_) {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    _youtubeController?.dispose();
    _videoPlayercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('YouTube Video Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _youtubeController != null
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.red),
                    ),
                    child: YoutubePlayer(
                      controller: _youtubeController!,
                      showVideoProgressIndicator: true,
                    ),
                  )
                : Container(),
            20.verticalSpace,
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelText: 'Enter YouTube URL',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                labelStyle: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              onPressed: _loadYouTubeVideo,
              child: Text(
                'Play Video',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20),
            _videoPlayercontroller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayercontroller.value.aspectRatio,
                    child: VideoPlayer(
                      _videoPlayercontroller,
                    ),
                  )
                : Container(),
            ElevatedButton(
              onPressed: () {
                _videoPlayercontroller.value.isPlaying
                    ? _videoPlayercontroller.pause()
                    : _videoPlayercontroller.play();
              },
              child: Icon(Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}




