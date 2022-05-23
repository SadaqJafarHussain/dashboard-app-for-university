import 'dart:convert';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:smart_tv/models/add_modal.dart';
import 'package:intl/intl.dart' as intel;

class AppProvider extends ChangeNotifier{

  String statusData;
bool _isOnline=false;
get isOnline=>_isOnline;
   internetChecker(){
    DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
         _isOnline=true;
         notifyListeners();
          break;
        case DataConnectionStatus.disconnected:
          _isOnline=false;
          notifyListeners();
          break;
      }
    });
  }
  Future getTable(int number)async{
     String url="https://alnashico.com/collage/api/daily/read.php";
    final response=number==0?await http.get(Uri.parse(url+"?day_name=${intel.DateFormat("EEEE").format(DateTime.now()).substring(0,3)}"))
                            :await http.get(Uri.parse(url));
    var decoded= json.decode(response.body);
    return decoded;
  }
  Stream<Map> tableStream(int number) async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 50));
      Map someTable =await getTable(number);
      yield someTable;
    }
  }
Future getStatus() async{
  final response=await http.get(Uri.parse("https://alnashico.com/collage/api/daily/check_status.php"));
  var decoded= jsonDecode(response.body);
  return decoded;
}
Stream<String> statusStream() async* {
  while (true) {
    await Future.delayed(const Duration(milliseconds: 50));
    Map status =await getStatus();
    yield status["status"].toString().trim();
  }
}
 Future getAdds()async{
  final response=await http.get(Uri.parse("https://alnashico.com/collage/api/ads/check_ads.php"));
  var decoded= json.decode(response.body);
    Map adds=decoded;
    Ads  _ads = Ads.fromJson(adds,decoded["url_file"]??"no");
    return _ads;
}
Stream<Ads> AdsStream() async* {
  while (true) {
    await Future.delayed(const Duration(milliseconds: 50));
    Ads someAds =await getAdds();
    yield someAds;
  }
}
}