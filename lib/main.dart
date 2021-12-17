import 'dart:async';

import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:ShivaneDesigning/HomePage.dart';
import 'package:ShivaneDesigning/TempImage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ShivaneDesigning/FurureDemo.dart';
import 'package:ShivaneDesigning/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String cusMobNo = "";
  String cusId = "";

  Future getUserPrefData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var prefPhone = sharedPreferences.getString(HelperFile.prefUserPhone);
    var prefPass = sharedPreferences.getString(HelperFile.prefUserPass);

    setState(() {
      cusMobNo = prefPhone.toString();
      cusId = prefPass.toString();
    });

    print("UserData:::\ncusMobNo : $cusMobNo\tcusId : $cusId");
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      print("am i stil alive?");

      getUserPrefData().whenComplete(() async {
        Timer(Duration(milliseconds: 1200), () {
          if (cusMobNo == "") {
            print("im not stored yet");
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          } else {
            print("im  stored in locally");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                        cusMobNo: cusMobNo,
                        cusId: cusId,
                        userData: [].toString())));
          }
        });
      });

      super.initState();
    }

    @override
    void didUpdateWidget(MyApp myApp) {
      print("did_myApp");
      super.didUpdateWidget(myApp);
      print("updated_myApp");
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: TempImage(),
      home: AnimatedSplashScreen(
        splash: Scaffold(
          body: Center(
            child: Image.asset(
              'assets/logo.png',
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        duration: 100,
        nextScreen: Login(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
      ),
    );
  }
}
