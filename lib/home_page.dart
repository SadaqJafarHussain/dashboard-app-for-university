import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intel;
import 'package:smart_tv/views/exam_table.dart';
import 'package:smart_tv/views/image_viewer.dart';
import 'package:smart_tv/views/table.dar.dart';
import 'package:smart_tv/views/text_view.dart';
import 'package:smart_tv/views/video_viewer.dart';
import 'package:smart_tv/widgets/loader.dart';
import 'package:smart_tv/widgets/loading_page.dart';
import 'package:smart_tv/widgets/no_internet.dart';
import 'package:smart_tv/widgets/no_table.dart';
import 'package:smart_tv/widgets/server_down.dart';
import 'Providers/app_provider.dart';
import 'models/add_modal.dart';
import 'models/exam_model.dart';
import 'models/table_modal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stream _exmTable;
  Stream _dailyTable;
  Stream _adds;
  Stream _status;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dailyTable= Provider.of<AppProvider>(context).tableStream(0).asBroadcastStream();
    _exmTable=Provider.of<AppProvider>(context).tableStream(1).asBroadcastStream();
    _adds=Provider.of<AppProvider>(context).AdsStream().asBroadcastStream();
    _status=Provider.of<AppProvider>(context).statusStream().asBroadcastStream();
  }
  @override
  void initState() {
    super.initState();
    getTable();

  }


   getTable()async{
     final response=await http.get(Uri.parse("https://alnashico.com/collage/api/daily/read.php?day_name=${intel.DateFormat("EEEE").format(DateTime.now()).substring(0,3)}"));
     String time=intel.DateFormat("y-MM-dd").format(DateTime.now());
     print(time);
     var decoded= jsonDecode(response.body);
    print(decoded);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<AppProvider>(
            builder: (context, snap, child) {
              return !snap.isOnline
                  ? NoInternet()
                  : StreamBuilder<Ads>(
                      stream: _adds,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Loader();
                        } else if (!snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          return Loader();
                        } else if (snapshot.data.image != "no") {
                          return PhotoViewer(
                            imageAds: snapshot.data.image,
                            url: snapshot.data.url,
                          );
                        } else if (snapshot.data.video != "no") {
                          return VideoViewer(
                            video: snapshot.data.video,
                            url: snapshot.data.url,
                          );
                        } else if (snapshot.data.text != "no") {
                          return TextView(
                            text: snapshot.data.text,
                          );
                        } else {
                         return StreamBuilder(
                             stream: _status,
                             builder:(context,status){
                               if(status.connectionState==ConnectionState.waiting){
                                 return Loader();
                               }
                               switch(status.data){
                                 case "daily":
                                   return showTable(true, _dailyTable);
                                   break;
                                 case "exam":
                                   return showTable(false, _exmTable);
                                   break;
                                 default :
                                   return ServerDown();
                                   break;
                               }
                             } );


                        }
                      },
                    );
            },
          ),
        ));
  }
  StreamBuilder showTable(bool isTable, Stream stream){
    return StreamBuilder(
        stream: stream,
        builder: (context, snap) {
          if (!snap.hasData) {
            return LoadingPage();
          } else if (snap.data["code"] == 400 ||
              snap.data["result"] == "fail") {
            return ServerDown();
          } else if (snap.data["data"] == null) {
            return NoTable();
          } else if(snap.connectionState==ConnectionState.active) {
            return isTable? SchoolTable(
                table: (snap.data["data"] as List)
                    .map((json) => ClassTable.fromJson(json))
                    .toList()):
                 ExamTable(
                table: (snap.data["data"] as List)
                    .map((json) => ExamModel.fromJson(json,snap.data["title"]))
                    .toList());
          }
          return LoadingPage();
        });
  }


}
