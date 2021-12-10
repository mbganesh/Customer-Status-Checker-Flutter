import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us"),),
      body: Center(child: Text("No Data Found :/"),),
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