import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_tv/widgets/loader.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  bool finish=false;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      finish=true;
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        body:finish? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Lottie.asset('assets/no-internet.json')),
              SizedBox(
                height: 20,
              ),
              const Text("No Internet ",
                style: TextStyle(fontSize: 30,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),),
                Padding(
                padding:  EdgeInsets.all(15),
                child: Text("انت غير متصل بالانترنت , تاكد من ان الواي فاي مشغله عندك , او قم بالتواصل مع مزود الخدمه لديك",
                  textAlign: TextAlign.center,

                  style: TextStyle(fontSize: 10.sp,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold

                  ),),
              ),
            ],
          ),
        ):Loader());
  }
}
