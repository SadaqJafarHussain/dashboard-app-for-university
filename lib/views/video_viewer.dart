import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_tv/widgets/loader.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  final String video;
  final String url;
  const VideoViewer({Key key,
    @required this.video,
    @required this.url
}) : super(key: key);
  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
   VideoPlayerController _controller;
  VoidCallback listener;


  @override
  void initState() {
    super.initState();
    listener=(){
      if(mounted){
        setState(() {
        });
      }
    };
    _controller = VideoPlayerController.network(
        "${widget.url}${widget.video}")
      ..addListener(listener)
      ..setVolume(1.0)
      ..setLooping(true)
      ..initialize()
      ..play();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:  _controller.value.isInitialized
            ? Stack(
              children: [
                AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Image.asset("images/uni.png",
                    height: 6.h,
                  ),
                ),
              ],
            )
            :  Center(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("...الرجاء الانتظار",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1C2833),
                  ),),
                SizedBox(
                  height: 2.h,
                ),
                Loader()
              ],
            ),
          ),
        ),
      )
    );
  }

   @override
   void dispose(){
     _controller.dispose();
     super.dispose();
     // player.release();
   }
}
