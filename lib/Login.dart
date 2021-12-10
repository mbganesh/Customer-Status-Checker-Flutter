import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_app/HomePage.dart';
import 'DataModel.dart';
import 'HelperFile.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

bool? isValidUser;
String data = "" ;

String userData = "";



// user info
String no = "";
String id = "";

Future<DataModel> submitData(String cusMobNo, String cusId) async {
  var response =
      await http.post(Uri.http(HelperFile.rootURL, HelperFile.loginPath), body: {
    "cusMobNo": cusMobNo,
    "cusId": cusId,
  });

  data = response.body;

  // print(data);

  var myJson = jsonDecode(data);

  print(myJson["message"]);




  if (myJson["success"] == true) {
    // print(myJson["message"]);

    isValidUser = true;
  } else if (myJson["success"] == false) {
    // print(myJson["message"]);

    isValidUser = false;
  }


  print("---------------");
  print(data);
  print("---------------");

  var passtohome = {} ;
  passtohome["cusId"] = cusId.toString();
  passtohome["cusMobNo"] = cusMobNo.toString();
  // passtohome["orderID"] = myJson["message"];

  // data = jsonDecode(passtohome.toString()).toString();

  userData =  passtohome.toString();

print("**************************************");
  // print(userData);

  userData = jsonEncode(data);
print("**************************************");


  return dataModelFromJson(data);
}

class _LoginState extends State<Login> {
  // new staff
  DataModel? myModel;
  TextEditingController phenoNoController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: Container(
              height: double.infinity,
              color: Color(0xFFffffff),
              child: Stack(
                children: [
                  Positioned(
                    // width: double.maxFinite,
                    left: 0.0,
                    top: 0.0,
                    child: Lottie.asset('assets/cloud_animation.json',
                        height: 250, fit: BoxFit.fitWidth),
                  ),
                  Positioned(
                    top: 15.0,
                    left: 100.0,
                    child: Center(
                      child: Container(
                        child: Image.asset(
                          'assets/white_logo.png',
                          height: 150,
                          width: 200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              "Login",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(HelperFile.appColor)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: phenoNoController,
                        maxLength: 10,
                        maxLines: 1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Phone Number.";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            // hintText: "Phone Number",
                            labelStyle:
                                TextStyle(color: Color(HelperFile.appColor)),
                            labelText: "Mobile Number",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(HelperFile.appColor)))),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: TextFormField(
                        controller: passWordController,
                        maxLines: 1,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter your Password.";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color(HelperFile.appColor)),
                            labelText: "PassWord",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(HelperFile.appColor)))),
                      )),
                  Container(
                    margin: EdgeInsets.only(left: 25.0),
                    child: Text("*Enter Customer ID printed in Receipt"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 25.0, right: 25.0),
                    width: double.infinity,
                    child: TextButton(
                      child: Text(
                        'Loin',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color(HelperFile.appColor))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String ph = phenoNoController.text;
                          String ps = passWordController.text;

                          no = ph ;
                          id = ps;

                          DataModel model = await submitData(ph, ps);

                          setState(() {
                            myModel = model;
                          });

                          if (isValidUser == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(cusMobNo:no , cusId: id , userData:data)));
                          } else {
                            final err = "Invalid UserName and PassWord";
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(err),
                              duration: Duration(milliseconds: 3000),
                            ));
                          }
                        }
                      },
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
