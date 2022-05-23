import 'package:flutter/material.dart';

class ClassTable {
String holeName;
String materialName;
String collegeName;
String stageName;
String dayName;
String timeFrom;
String timeTo;



ClassTable.fromJson (Map <dynamic,dynamic> json){
  holeName=json["hole_name"].toString();
  collegeName=json["univers_name"].toString();
  materialName=json["material_name"].toString();
  stageName=json["stage_name"].toString();
  dayName=json["day_name"].toString();
  timeFrom=json["daily_time_from"].toString()??"no time";
  timeTo=json["daily_time_to"].toString()??"no time";

}
}