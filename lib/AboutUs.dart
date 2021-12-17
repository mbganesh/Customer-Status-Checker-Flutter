import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

void helpmeOutThis() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  print("init_about");
  print(sharedPreferences.getString(HelperFile.prefUserPass).toString());
  print("state_about");
}

class _AboutUsState extends State<AboutUs> {
  String textDood = "hello";

  VideoPlayerController? controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(HelperFile().akkaVideo)
      ..initialize().then((_) {
        setState(() {});
      });

    controller!.play();
  }

  // @override
  // void initState() {
  //   super.initState();

  //   helpmeOutThis();
  // }

  @override
  void dispose() {
    print("dispo_about???");
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Color(HelperFile.appColor),
      ),
      body: ListView(
        children: [
          // *********** <-   Video player  -> ***************** //
          Container(
            height: 200,
            width: double.infinity,
            child: controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: controller!.value.aspectRatio,
                    child: VideoPlayer(controller!),
                  )
                : Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText("Loading...")
                      ],
                      isRepeatingAnimation: true,
                    ),
                  ),
          ),

// *********** <-   our story  -> ***************** //
          Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "OUR STORY",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(HelperFile.appColor)),
              ))),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  HelperFile().ourStory1,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  HelperFile().ourStory2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // *********** <-   where our story led to  -> ***************** //
          Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "WHERE OUR STORY LED TO",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(HelperFile.appColor)),
              ))),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset("assets/about_pic1.jpg"),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              HelperFile().whereOutStory,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // *********** <-   vision & mission  -> ***************** //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                // width: 250,
                child: Card(
                  // color: Color(0xffDDD),
                  elevation: 10,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "VISION",
                        style: TextStyle(
                            color: Color(HelperFile.appColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(HelperFile().vision))
                  ]),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                // width: 250,
                child: Card(
                  // color: Color(0xffDDD),
                  elevation: 10,
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "MISSION",
                        style: TextStyle(
                            color: Color(HelperFile.appColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(HelperFile().mission))
                  ]),
                ),
              ),
              SizedBox(
                width: 5,
              )
            ],
          ),
          // *********** <-   whats ahead  -> ***************** //
          Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "WHATS AHEAD",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(HelperFile.appColor)),
              ))),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              "assets/about_pic2.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  HelperFile().whatsAhead1,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  HelperFile().whatsAhead2,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  HelperFile().whatsAhead3,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // *********** <-   Why shivane's designing  -> ***************** //
          Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                  child: Text(
                "WHY SHIVANE'S DESIGNING",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(HelperFile.appColor)),
              ))),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              "assets/about_pic3.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      HelperFile().whyShivaneDesigning1,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      HelperFile().whyShivaneDesigning2,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      HelperFile().whyShivaneDesigning3,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
          Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: SvgPicture.asset(
                  "assets/abt_bot1.svg",
                  color: Color(HelperFile.appColor),
                ),
                title: Text(
                  "WORLDWIDE DELIVERY",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(HelperFile.appColor)),
                ),
                subtitle: Text("With Nominal Shipping Charges"),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: SvgPicture.asset(
                  "assets/abt_bot2.svg",
                  color: Color(HelperFile.appColor),
                ),
                title: Text(
                  "100% HANDPICKED",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(HelperFile.appColor)),
                ),
                subtitle: Text("Selectively Picked by The Team"),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: SvgPicture.asset(
                  "assets/abt_bot3.svg",
                  color: Color(HelperFile.appColor),
                ),
                title: Text(
                  "ASSURED QUALITY",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(HelperFile.appColor)),
                ),
                subtitle: Text("Our products meet quality standards"),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: SvgPicture.asset(
                  "assets/abt_bot4.svg",
                  color: Color(HelperFile.appColor),
                ),
                title: Text(
                  "SILK MARK CERTIFIED",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(HelperFile.appColor)),
                ),
                subtitle: Text("Textiles made of Pure Silk"),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (controller!.value.isPlaying) {
              controller!.pause();
            } else {
              controller!.play();
            }
          });
        },
        child:
            Icon(controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
        // child: controller!.value.isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        elevation: 10,
      ),
    );
  }
}
