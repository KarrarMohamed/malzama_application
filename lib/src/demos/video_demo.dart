import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VideoDemo(),
      title: 'Video',
    );
  }
}




class VideoDemo extends StatefulWidget {
  @override
  _VideoDemoState createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  var _controller;
  
  @override
  void initState() {
    _controller = new YoutubePlayerController(initialVideoId: 'UUzYbJloIps',flags: YoutubePlayerFlags(
      isLive: false,
      disableDragSeek: true,
      hideThumbnail: true,
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
