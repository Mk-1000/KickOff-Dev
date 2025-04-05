import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({super.key});

  @override
  State<LogoAnimation> createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation> {
  late VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.asset("assets/image/splashVideo.mp4")..initialize().then((value) {
      setState(() {
        
      });
      
    })..setVolume(0.0); 
    _playVideo();
    super.initState();
  }
  void _playVideo() async {
    _controller.play();
    await Future.delayed(const Duration(seconds: 4));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:_controller.value.isInitialized ? 
      AspectRatio(aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
      )
      :Container()  ,
    );
  }
}