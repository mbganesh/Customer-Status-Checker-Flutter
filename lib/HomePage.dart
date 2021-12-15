import 'dart:convert';
import 'package:ShivaneDesigning/Login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:ShivaneDesigning/AboutUs.dart';
import 'package:ShivaneDesigning/DetailsPage.dart';
import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

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
                      FlutterPhoneDirectCaller.callNumber("9585501762");
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
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"))
              ],
            ));
  }

  Future showContactUsDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("Contact Us"),
              content: new Text(
                  "Komala Creation\n4, Chinnakoil, Murugankurichi\nTirunelveli - 627002"),
              actions: [
                TextButton(
                    onPressed: () {
                      launcher.launch(HelperFile.mapURL);
                    },
                    child: Text("Map")),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  Future showAppInfoDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text("App Info"),
              content: new Text("Shivane Designing\n" + versionCode),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  Future<void> _futureIdRefresh() async {
    print("//////////////////////");
    _tempSharef();
    print("//////////////////////");

    print("Home Paga refreshed");
    _updateIDs(widget.cusId, widget.cusMobNo);
    return Future.delayed(Duration(seconds: 10));
  }

  void _updateIDs(String? cusId, String? cusMobNo) async {
    print("_updateIDs");
    var response = await http
        .post(Uri.http(HelperFile.rootURL, HelperFile.loginPath), body: {
      "cusMobNo": cusMobNo,
      "cusId": cusId,
    });
    var data = response.body;
    var da = jsonEncode(jsonDecode(data)["message"]);
    setState(() {
      orderIds = jsonDecode(da.toString());
    });
  }

  List orderIds = [];
  String versionCode = "";

  void _tempSharef() async {
    print("||||||||||||||||||||||||");

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    print(sharedPreferences.getString(HelperFile.prefUserPass).toString() +
        "cxcxccxcxxccx");

    print("||||||||||||||||||||||||");
  }

  @override
  Widget build(BuildContext context) {
    // {cusId: cus-10657, cusMobNo: 9876543245}  //  login to home -> datas

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      // String appName = packageInfo.appName;
      // String packageName = packageInfo.packageName;
      // String version = packageInfo.version;
      // String buildNumber = packageInfo.buildNumber;
      versionCode = "Version Code : " +
          packageInfo.version +
          "\n" +
          "Build Number : " +
          packageInfo.buildNumber;
    });

    @override
    void initState() {
      super.initState();
      print("InitState: called");
      setState(() {
        orderIds = jsonDecode(widget.userData.toString());
      });
      // print(orderIds);
      // print("orderIdsPRO");
    }

    @override
    void didUpdateWidget(HomePage homePage) {
      print("did");
      super.didUpdateWidget(homePage);
      print("updated");
    }

    String ordId = "";

    return Scaffold(
      backgroundColor: Color(HelperFile.bgColor),
      drawer: Drawer(
        child: ListView(
          children: [
            Image.asset('assets/logo.png'),
            ListTile(
              title: Text("About Us"),
                leading: SvgPicture.asset(
                'assets/ic_about_us.xml',
                width: 25,
                height: 25,
                // color: Color(HelperFile.appColor),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              title: Text("Contact Us"),
              leading: Icon(Icons.contact_mail),
              onTap: () {
                showContactUsDialog(context);
              },
            ),
            ListTile(
              title: Text("App Info"),
              leading: Icon(Icons.info),
              onTap: () {
                showAppInfoDialog(context);
              },
            ),
            Text("Website"),
            ListTile(
              title: Text("Online Shopping"),
              leading: Icon(Icons.web),
              onTap: () {
                launcher.launch("https://shivanesboutique.com/");
              },
            ),
            Text("Social Touch"),
            ListTile(
              title: Text("Facebook"),
                 leading: SvgPicture.asset(
                'assets/facebook.svg',
                width: 25,
                height: 25,
                color: Color(HelperFile.appColor),
              ),
              onTap: () {
                launcher.launch(HelperFile.smFB);
              },
            ),
            ListTile(
              title: Text("Instagram"),
               leading: SvgPicture.asset(
                'assets/facebook.svg',
                width: 25,
                height: 25,
                color: Color(HelperFile.appColor),
              ),
              onTap: () {
                launcher.launch(HelperFile.smIn);
              },
            ),
            ListTile(
              title: Text("Youtube"),
              leading: SvgPicture.asset(
                'assets/youtube.svg',
                width: 25,
                height: 25,
                color: Color(HelperFile.appColor),
              ),
              onTap: () {
                launcher.launch(HelperFile.smYt);
              },
            ),
            ListTile(
              title: Text("Twitter"),
             leading: SvgPicture.asset(
                'assets/twitter.svg',
                width: 25,
                height: 25,
                color: Color(HelperFile.appColor),
              ),
              onTap: () {
                launcher.launch(HelperFile.smTw);
              },
            ),
          Padding(padding: EdgeInsets.all(5),child:   Text("Exit"),),
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
        title: Image.asset(
          "assets/white_logo.png",
          width: 150,
          height: 50,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _futureIdRefresh();
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Color(HelperFile.appColor),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    "My Orders",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderIds.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(HelperFile.appColor),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Card(
                        child: TextButton(
                      onPressed: () {
                        setState(() {
                          ordId = orderIds[index];
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                cusMobNo: widget.cusMobNo,
                                cusId: widget.cusId,
                                orderID: ordId)));
                      },
                      child: Text(
                        orderIds[index],
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
              "POWERED BY",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(HelperFile.appColor),
              ),
            ),
            TextButton(
              child: Text(
                "Netcom Computers Pvt Ltd",
                style: TextStyle(fontSize: 9, color: Colors.black),
              ),
              onPressed: () {
                launcher.launch("https://netcomcomputersindia.com/",
                    forceWebView: true);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(HelperFile.appColor),
        onPressed: () {
          showCallDialog(context);
        },
        tooltip: "Need Helps?",
        elevation: 10,
        child: Icon(Icons.phone),
      ),
    );
  }
}
