import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart'as intel;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_tv/table.dar.dart';
import 'package:smart_tv/widgets/photo_or_video_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (orientation,constraints,deviceType){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home:const  MyHomePage(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
 const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List table=[];
  List adds=[];

@override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("isThereAdd").snapshots(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var add=(snapshot.data!.docs.first.data() as Map)["isAdd"];
            if(add.toString().trim()=="0") {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("table").snapshots(),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                 return SchoolTable(table: snapshot.data!.docs);
                });
            }
            else{
              return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("adds").snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting||!snapshot.hasData){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                   return snapshot.data!.docs.first["image"]!=""?
                   PhotoVideoViewWidget( type: "image", url: snapshot.data!.docs.first["image"],time: snapshot.data!.docs.first["add_duration"],):
                   PhotoVideoViewWidget(type: "video", url: snapshot.data!.docs.first["video"],time:snapshot.data!.docs.first["add_duration"]);
                  });
            }
          },
        ),
                  );
  }
}

