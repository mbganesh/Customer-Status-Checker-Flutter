import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/HelperFile.dart';
import 'package:my_app/OrderModel.dart';
import 'package:http/http.dart' as http;

class FurureDemo extends StatefulWidget {
  const FurureDemo({Key? key}) : super(key: key);

  @override
  _FurureDemoState createState() => _FurureDemoState();
}

var jsonObj = {};

Future<OrderModel> futureOrder() async {
  var response = await http.post(
      Uri.parse("http://13.234.126.183:3002/api/customerLoginData"),
      body: {
        "cusMobNo": "9876543245",
        "cusId": "cus-10657",
        "orderID": "K001"
      });
  print(response.body);

  jsonObj = jsonDecode(response.body);

  return orderModelFromJson(response.body);
}

class _FurureDemoState extends State<FurureDemo> {
  @override
  void initState() {
    super.initState();
    initStep();
  }

  void initStep() async {
    OrderModel m = await futureOrder();

    setState(() {
      model = m;
    });
  }

  OrderModel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FurureBuilder"),
      ),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: futureOrder(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      child: Card(
                          color: Color(HelperFile.appColor),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "Order ID  : " +
                                    jsonObj["message"][0]["orderID"].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    Text(jsonObj["message"][0]["orderDate"].toString()),
                    Text(jsonObj["message"][0]["name"].toString()),
                    Text(jsonObj["message"][0]["mobNo"].toString()),
                    Text(jsonObj["message"][0]["deliveryDate"].toString()),
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
   
    );
  }
}
