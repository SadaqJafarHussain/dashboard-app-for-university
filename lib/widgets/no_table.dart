import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart' as intel;

import 'flare.dart';
class NoTable extends StatefulWidget {
  @override
  _NoTableState createState() => _NoTableState();
}

class _NoTableState extends State<NoTable> {
  String _timeString;
  
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }
  
  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Color(0xff1C2833),
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.yellow,
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "الجامعة الوطنية للعلوم والتكنلوجبا  ",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 10.sp,
                        ),
                      ),
                      Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          Text(
                            "$_timeString ${intel.DateFormat(' a').format(DateTime.now())}",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                              fontSize: 6.sp,
                              color: Color(0xff1c294b),
                            ),
                          ),
                          Text(
                            DateTime.now()
                                .toString()
                                .replaceAll("-", "/")
                                .substring(0, 10),
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                              fontSize: 6.sp,
                              color: Color(0xff1c294b),
                            ),
                          ),
                          Text(
                            intel.DateFormat("EEEE").format(DateTime.now()),
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.bold,
                              fontSize: 7.sp,
                              color: Color(0xff1c294b),
                            ),
                          ),
                        ],
                      ),
                      Image.asset("images/uni.png",
                        height: 6.h,
                      ),
                    ],
                  ),
                ),
               Expanded(
                 child: Lottie.asset('assets/101573-search-file.json'),
               ),
                Text("لايوجد جدول",style: TextStyle(
                  color: Color(0xffFAFAFA),
                  fontSize: 10.sp,
                  fontFamily: "Cairo",
                ),),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Flare(
              color: Color(0xfff9e9b8),
              offset: Offset(width, -height),
              bottom: -50,
              flareDuration: Duration(seconds: 17),
              left: 100,
              height: 60,
              width: 60,
            ),
            Flare(
              color: Color(0xfff9e9b8),
              offset: Offset(MediaQuery.of(context).size.width, -MediaQuery.of(context).size.height),
              bottom: -50,
              flareDuration: Duration(seconds: 12),
              left: 10,
              height: 25,
              width: 25,
            ),
            Flare(
              color: Color(0xfff9e9b8),
              offset: Offset(width, -height),
              bottom: -40,
              left: -100,
              flareDuration: Duration(seconds: 18),
              height: 50,
              width: 50,
            ),
            Flare(
              color: Color(0xfff9e9b8),
              offset: Offset(width, -height),
              bottom: -50,
              left: -80,
              flareDuration: Duration(seconds: 15),
              height: 50,
              width: 50,
            ),
            Flare(
              color: Color(0xfff9e9b8),
              offset: Offset(width, -height),
              bottom: -20,
              left: -120,
              flareDuration: Duration(seconds: 12),
              height: 40,
              width: 40,
            )
          ],
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return intel.DateFormat(' hh : mm : ss').format(dateTime);
  }
}
