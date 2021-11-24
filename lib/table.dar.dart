import 'dart:async';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intel;
import 'package:smart_tv/main.dart';
class SchoolTable extends StatefulWidget {
  const SchoolTable({Key? key,required this.table}) : super(key: key);
   final List table;
  @override
  _SchoolTableState createState() => _SchoolTableState();
}

class _SchoolTableState extends State<SchoolTable> {
  late String _timeString;
  @override
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
    return Column(
      children: [
        Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.yellow,
                height: 12.h,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "الجامعة الوطنية للعلوم والتكنلوجبا ",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "جدول المواد الدراسية اليومي",
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.yellow,
                height: 12.h,
                child: Center(
                  child: Column(
                    textDirection: TextDirection.rtl,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "$_timeString ${intel.DateFormat(' a').format(DateTime.now())}",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                          color: Colors.black,
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
                          fontSize: 8.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        intel.DateFormat("EEEE").format(DateTime.now()),
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.yellow.shade500,
          height: 4.h,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        "القاعة",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 9.sp,
                          color: Colors.black,
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
                        "الكلية والمرحلة",
                        style: TextStyle(
                          fontFamily: "Cairo",
                          fontSize: 9.sp,
                          color: Colors.black,
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
                          fontSize: 9.sp,
                          color: Colors.black,
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
                          color: Colors.black,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              color: Colors.black87,
              child: ListView.builder(
                  itemCount: widget.table.length,
                  itemBuilder: (context, index) {
                    var tab = widget.table[index];
                    return Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        SizedBox(
                          width: 5.w,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                (tab.data() as Map)["class"],
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 9.sp,
                                  color: Colors.white,
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
                                "${(tab.data() as Map)["stage"]}",
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 9.sp,
                                  color: Colors.yellow,
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
                                (tab.data() as Map)["subject"],
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  fontSize: 9.sp,
                                  color: Colors.cyanAccent,
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
                                "${(tab.data() as Map)["starttime"].toString()}--${(tab.data() as Map)["endtime"].toString()} ",
                                style: TextStyle(
                                  fontFamily: "Cairo",
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                      ],
                    );
                  }),
            )),
      ],
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
