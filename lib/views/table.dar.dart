import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intel;
import '../models/table_modal.dart';
import '../widgets/flare.dart';

class SchoolTable extends StatefulWidget {
  const SchoolTable({Key key, @required this.table})
      : super(key: key);
 final List<ClassTable> table;
  @override
  _SchoolTableState createState() => _SchoolTableState();
}

class _SchoolTableState extends State<SchoolTable> {
  final ScrollController _controller = ScrollController();
  bool isLast = false;
  Timer timer1;
  Timer timer2;

  String _timeString;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    timer1 =
        Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    timer2 = Timer.periodic(const Duration(seconds: 30), (Timer t) => scroll());
    super.initState();
  }

  @override
  void dispose() {
    timer1.cancel();
    timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff1C2833),
        body:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.yellow,
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "   الجامعة الوطنية للعلوم والتكنلوجبا  جدول المواد الدراسية اليومي    ",
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
                        "${intel.DateFormat("EEEE").format(DateTime.now())}",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          fontSize: 7.sp,
                          color: Color(0xff1c294b),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "images/uni.png",
                    height: 6.h,
                  ),
                ],
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "القاعة",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 8.sp,
                            color: Color(0xff1c294b),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "الكلية ",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 8.sp,
                            color: Color(0xff1c294b),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          " المرحلة",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 8.sp,
                            color: Color(0xff1c294b),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          "المادة",
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 8.sp,
                            color: Color(0xff1c294b),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                "الوقت",
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  color: Color(0xff1c294b),
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )

                ],
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    color: Color(0xff1C2833),
                    child: ListView.builder(
                        controller: _controller,
                        itemCount: widget.table.length,
                        itemBuilder: (context, index) {
                          return Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    widget.table[index].holeName ?? "---",
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 8.sp,
                                      color:Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    widget.table[index].collegeName ?? "---",
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    widget.table[index].stageName ?? "---",
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    widget.table[index].materialName ?? "---",
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ), Expanded(
                                      child: SizedBox(
                                        child: Text(
                                          "${widget.table[index].timeFrom.substring(0, 5) ?? "00:00"}--${widget.table[index].timeTo.substring(0, 5) ?? "00:00"}",
                                          style: TextStyle(
                                            fontFamily: "Cairo",
                                            color: Colors.white,
                                            fontSize: 8.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                            ],
                          );
                        }),
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
                    offset: Offset(MediaQuery.of(context).size.width,
                        -MediaQuery.of(context).size.height),
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
              )),

            ],
          ),
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

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      isLast = true;
    });
  }

  void _scrollUp() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: 3),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      isLast = false;
    });
  }

  void scroll() {
    if (isLast) {
      _scrollUp();
    } else {
      _scrollDown();
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return intel.DateFormat(' hh : mm : ss').format(dateTime);
  }
}
