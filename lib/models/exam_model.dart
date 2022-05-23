class ExamModel {
  String holeName;
  String materialName;
  String collegeName;
  String stageName;
  String dayName;
  String seqFrom;
  String seqTo;
  String title;
  String date;


  ExamModel.fromJson (Map <dynamic,dynamic> json,String title){
    holeName=json["hole_name"].toString();
    collegeName=json["univers_name"].toString();
    materialName=json["material_name"].toString();
    stageName=json["stage_name"].toString();
    dayName=json["day_name"].toString();
    seqFrom=json["sequence_from"].toString()??"no seq";
    seqTo=json["sequence_to"].toString()??"no seq";
    this.title=title;
    date=json["exam_date"].toString()??"no date";
  }
}