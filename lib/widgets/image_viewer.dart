import 'dart:async';
import 'package:circular_countdown/circular_countdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

class PhotoViewer extends StatefulWidget {
  final String imageAds;
  final int time;
  const PhotoViewer({Key? key, required this.imageAds,
  required this.time,
  }) : super(key: key);
  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  bool finishLoading=false;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                widget.imageAds,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null){
                    print("im heeeerrrre");
                    SchedulerBinding.instance!.addPostFrameCallback((_) {
                      setState(() {
                        finishLoading=true;
                      });
                    });
                    return child;
                  }
                  SchedulerBinding.instance!.addPostFrameCallback((_) {
                    setState(() {
                      finishLoading=false;
                    });
                  });
                  return Center(
                    child: SizedBox(
                      width: 50.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(".... سوف يظهر الاعلان بعد قليل",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                          ),),
                          LinearProgressIndicator(
                            backgroundColor:Colors.purple.shade200 ,
                            valueColor:const AlwaysStoppedAnimation<Color>(Colors.purple),
                            minHeight: 1.h,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
     finishLoading==false? Container(
       height: 5.h,
       decoration:const BoxDecoration(
           shape: BoxShape.circle,
       ),
     ): Positioned(
        left: 10,
        top: 10,
        child: Container(
          height: 5.h,
          decoration:const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black45
          ),
          child: TimeCircularCountdown(
            shouldDowngradeUnit: true,
            countdownTotalColor: Colors.white,
            countdownRemainingColor: Colors.yellow.shade800,
            strokeWidth: 5,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 8.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo"
            ),
            unit: CountdownUnit.second,
            countdownTotal: widget.time,
            onUpdated: (unit, remainingTime) {

            },
            onFinished: () {
              FirebaseFirestore.instance.collection("isThereAdd").get().then((value) => {
                FirebaseFirestore.instance.collection("isThereAdd").doc(value.docs.first.id.toString()).update({
                  "isAdd":0,
                }),
              });
              FirebaseFirestore.instance.collection("adds").get().then((value) => {
                FirebaseFirestore.instance.collection("adds").doc(value.docs.first.id.toString()).update({
                  "image":"",
                }),
              });
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (ctx)=>const MyHomePage()));
            },
          ),
        ),
      ),
        ],
      ),
    );
  }
}
