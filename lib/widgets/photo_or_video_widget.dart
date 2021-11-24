import 'package:flutter/material.dart';

import 'image_viewer.dart';
import 'video_viewer.dart';
class PhotoVideoViewWidget extends StatelessWidget {
  final String type;
  final String url;
  final int time;

  const PhotoVideoViewWidget({ Key? key,required  this.type, required this.url,required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == "video"
        ? VideoViewWidget(
      videoUrl: url,
      time: time,
    )
        : PhotoViewWidget(
      imageUrl: url,
      time: time,
    );
  }
}

class PhotoViewWidget extends StatelessWidget {
  final String imageUrl;
  final int time;

  const PhotoViewWidget({ Key? key,required this.imageUrl,required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoViewer(imageAds: imageUrl,time: time,);
  }
}

class VideoViewWidget extends StatelessWidget {
  final String videoUrl;
  final int time;

  const VideoViewWidget({ Key? key,required this.videoUrl,required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VideoViewer(videoUrl: videoUrl,time: time,);
  }
}