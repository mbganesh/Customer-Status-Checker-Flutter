import 'dart:convert';
import 'package:my_app/DataModel.dart';
import 'package:my_app/Login.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:my_app/AboutUs.dart';
import 'package:my_app/DetailsPage.dart';
import 'package:my_app/HelperFile.dart';

class HomePage extends StatefulWidget {
  final String? cusMobNo;
  final String? cusId;
  final String? userData;

  const HomePage(
      {Key? key,
      @required this.cusMobNo,
      @required this.cusId,
      @required this.userData})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // String data = "sample json data";

  String getData() {
    if (widget.userData == null) {
      return '';
    } else {
      return (widget.userData).toString();
    }
  }

  Future showCallDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Shivane Designing"),
              content: new Text("Need Help? Just make a Call."),
              actions: [
                TextButton(
                    onPressed: () {
                      FlutterPhoneDirectCaller.callNumber("9702470579");
                    },
                    child: Text("ok")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
              ],
            ));
  }

  Future showSignOutDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Signout"),
              content: new Text("Are you sure want to Exit?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("OK")),
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Cancel"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    // {cusId: cus-10657, cusMobNo: 9876543245}  //  login to home -> datas

    List getOrderIds() {
      print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*");

      print(widget.cusId);
      print(widget.cusMobNo);

      var jn = jsonDecode(widget.userData.toString());
      print(jn["message"]);

      print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*");

      return jn["message"];
    }

    String ordId = "";

    // void testMeth () {

    //   var root = jsonDecode(widget.userData.toString());

    //   var perOrderJson = {};
    //   // perOrderJson["cusMobNo"] = root
    // }

    return Scaffold(
      backgroundColor: Color(HelperFile.bgColor),
      drawer: Drawer(
        child: ListView(
          children: [
            Image.asset('assets/logo.png'),
            ListTile(
              title: Text("About Us"),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              title: Text("Contact Us"),
              leading: Icon(Icons.contact_mail),
            ),
            ListTile(
              title: Text("App Info"),
              leading: Icon(Icons.info),
            ),
            Text("Website"),
            ListTile(
              title: Text("Online Shopping"),
              leading: Icon(Icons.web),
            ),
            Text("Social Touch"),
            ListTile(
              title: Text("Facebook"),
              leading: Icon(Icons.facebook),
            ),
            ListTile(
              title: Text("Instagram"),
              leading: Icon(Icons.facebook_outlined),
            ),
            ListTile(
              title: Text("Youtube"),
              leading: Icon(Icons.youtube_searched_for_outlined),
            ),
            ListTile(
              title: Text("Twitter"),
              leading: Icon(Icons.assignment),
            ),
            Text("Exit"),
            ListTile(
              title: Text("SignOut"),
              leading: Icon(Icons.logout),
              onTap: () {
                showSignOutDialog(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(HelperFile.appColor),
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Center(
                  child: Text(
                "My Orders",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getOrderIds().length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  height: 75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.red.shade600,
                      Colors.red.shade300,
                    ]),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Card(
                      child: TextButton(
                    onPressed: () {
                      setState(() {
                        ordId = getOrderIds()[index];
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsPage(
                              cusMobNo: widget.cusMobNo,
                              cusId: widget.cusId,
                              orderID: ordId)));
                    },
                    child: Text(
                      getOrderIds()[index],
                      style: TextStyle(
                          color: Color(HelperFile.appColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  )),
                );
              },
            ),
          ),
          Text(
            "POWER BY",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          TextButton(
            child: Text(
              "Netcom Computers Pvt Ltd",
              style: TextStyle(fontSize: 9),
            ),
            onPressed: () {
              launcher.launch("https://netcomcomputersindia.com/",
                  forceWebView: true);
            },
            // style: TextStyle(
            //   fontWeight: FontWeight.bold,
            //   color: Colors.blue,
            // ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(HelperFile.appColor),
        onPressed: () {
          showCallDialog(context);
          // getOrderIds();
        },
        tooltip: "Need Helps?",
        elevation: 10,
        child: Icon(Icons.phone),
      ),
    );
  }
}
