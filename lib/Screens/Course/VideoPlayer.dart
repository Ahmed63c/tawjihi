import 'package:tawjihi/Utils/ColorProperties.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoApp extends StatefulWidget {
  String videoUrl;
  VideoApp(this.videoUrl);

  @override
  _VideoAppState createState() => _VideoAppState(videoUrl);
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  String videoUrl;

  _VideoAppState(this.videoUrl);

  @override
  void initState() {
    _controller = VideoPlayerController.network(videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    _controller.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Column(
      children: [
        Container( width: MediaQuery.of(context).size.width-128,
            height:MediaQuery.of(context).size.height/2 ,

              child: VideoPlayer(_controller)),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ),
        )
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

//appBar: AppBar(
//title: Text(""),
//backgroundColor: ColorProperties.AppColor,
//),

//floatingActionButton: FloatingActionButton(
//onPressed: () {
//setState(() {
//_controller.value.isPlaying
//? _controller.pause()
//    : _controller.play();
//});
//},
//child: Icon(
//_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//),
//),
