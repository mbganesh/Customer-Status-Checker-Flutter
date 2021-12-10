import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:my_app/FurureDemo.dart';
import 'package:my_app/Login.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

       

      home: AnimatedSplashScreen(
        splash: Scaffold(
          body: Center(
          
            child:  Image.asset('assets/logo.png' , width: double.infinity,  height: double.infinity,),
          ),
        ), 
        duration: 1000,
        nextScreen: Login(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white,
        ),
    
    );
  }
}