import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

void helpmeOutThis () async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print("init_about");
        print(sharedPreferences.getString(HelperFile.prefUserPass).toString());
    print("state_about");
}

class _AboutUsState extends State<AboutUs> {
  String textDood = "hello";

  @override
  void initState() {
    super.initState();

   helpmeOutThis();
  }


  @override
  void dispose() {
    print("dispo_about???");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(textDood),
            TextButton(
                onPressed: () {
                  setState(() {
                    textDood = "Hola Flutter !";
                  });
                },
                child: Text("Hit me Flutter Devz")),
          ],
        ),
      ),
    );
  }
}

/*

  Container(
            child: Stack(
              children: [
                Positioned(
                  top: 10.0,
                  child: Image.asset(
                    'assets/logo.png',
                    height: 75.0,
                  ),
                ),
                Positioned(
                  top: 0.0,
                  child: Lottie.asset('assets/cloud_animation.json',
                      fit: BoxFit.fitWidth),
                )
              ],
            ),
          ),
        

*/