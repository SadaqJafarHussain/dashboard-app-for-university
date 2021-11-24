import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:smart_tv/main.dart';

class VideoViewer extends StatefulWidget {
  final String videoUrl;
  final int time;
  const VideoViewer({Key? key,
    required this.videoUrl,
    required this.time,
}) : super(key: key);
  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  final FijkPlayer player = FijkPlayer();

  @override
  void initState() {

    super.initState();
    player.setDataSource(widget.videoUrl, autoPlay: true,
    ).then((value) => {
      player.setVolume(100.0)
    });
    player.addListener(() {
      if(player.value.completed){
        player.start();

      }
    });
    Timer( Duration(seconds:widget.time+20/*widget.time+20*/), () async{
      FirebaseFirestore.instance.collection("isThereAdd").get().then((value) => {
        FirebaseFirestore.instance.collection("isThereAdd").doc(value.docs.first.id.toString()).update({
          "isAdd":0,
        }),
      });
      FirebaseFirestore.instance.collection("adds").get().then((value) => {
        FirebaseFirestore.instance.collection("adds").doc(value.docs.first.id.toString()).update({
          "video":"",
        }),
      });
    });
  }
  @override
  void dispose(){
    super.dispose();
    player.release();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FijkView(
            player: player,
          ),
        ),
    );
  }
}
