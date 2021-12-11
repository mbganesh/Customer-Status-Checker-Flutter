import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart'; // for date convertor
import 'package:flutter/material.dart';
import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:ShivaneDesigning/OrderModel.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final String? cusMobNo;
  final String? cusId;
  final String? orderID;

  const DetailsPage(
      {Key? key,
      @required this.cusMobNo,
      @required this.cusId,
      @required this.orderID})
      : super(key: key);
// final String myValue;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var jsonObj = {};

  Future<OrderModel> futureOrder() async {
    var response = await http.post(
        Uri.parse("http://13.234.126.183:3002/api/customerLoginData"),
        body: {
          "cusMobNo": widget.cusMobNo,
          "cusId": widget.cusId,
          "orderID": widget.orderID
        });

    jsonObj = jsonDecode(response.body);

print(jsonObj["message"][0]["salwarData"].length);

    return orderModelFromJson(response.body);
  }

  OrderModel? orderModel;

  String getDateFormat(String date) {
    var myFormat = DateFormat("dd-MM-yyyy");
    String myDate = myFormat.format(DateTime.parse(date));
    return myDate;
  }

  Uint8List getImageView(String uri) {
    Uint8List _bytes;

    try {
      _bytes = base64.decode(uri.split(',').last);
      print(_bytes.toString());
      return _bytes;
    } on Exception catch (exception) {
      print(HelperFile.no_image);
      _bytes = base64.decode(HelperFile.no_image.split(',').last);
      print(_bytes.toString());
      return _bytes;
    } catch (e) {
      _bytes = base64.decode(HelperFile.no_image.split(',').last);
      print(_bytes.toString());
      return _bytes;
    }
  }

  @override
  void initState() {
    super.initState();
    initStep();
  }

  void initStep() async {
    OrderModel m = await futureOrder();
    setState(() {
      orderModel = m;
    });
  }

  Future<void> _futureRefresher() async {
    print("Paga refreshed");
    initStep();
    return Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(HelperFile.bgColor),
        appBar: AppBar(
          backgroundColor: Color(HelperFile.appColor),
          title: Text("Order Details"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _futureRefresher();
          },
          child: Center(
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
                              margin: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Order ID  : " +
                                        jsonObj["message"][0]["orderID"]
                                            .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Card(
                            // elevation: 0,
                            margin: EdgeInsets.only(left: 25.0, right: 25.0),
                            child: Column(
                              children: [
                                Center(
                                    child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color(HelperFile.appColor)),
                                  child: Center(
                                      child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Delivery Status",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                )),
                                Padding(
                                    padding: EdgeInsets.all(25),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      color: Color(0xff00ADB5),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            jsonObj["message"][0]["orderStatus"]
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            )),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 150,
                              // height: 100,
                              child: Card(
                                  // elevation: 0,

                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.only(
                                  //   bottomLeft: Radius.circular(50),
                                  //   bottomRight: Radius.circular(50),
                                  // )),

                                  // margin: EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Column(
                                children: [
                                  Center(
                                      child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(HelperFile.salwarColor)),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Salwar Count",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                  )),
                                  Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Card(
                                        shape: CircleBorder(),
                                        color: Color(HelperFile.salwarColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              jsonObj["message"][0]
                                                      ["salwarCount"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 150,
                              // height: 100,
                              child: Card(
                                  // elevation: 0,

                                  // shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.only(
                                  //   bottomLeft: Radius.circular(50),
                                  //   bottomRight: Radius.circular(50),
                                  // )),

                                  // margin: EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Column(
                                children: [
                                  Center(
                                      child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(HelperFile.blouseColor)),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Blouse Count",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                  )),
                                  Padding(
                                      padding: EdgeInsets.all(30),
                                      child: Card(
                                        shape: CircleBorder(),
                                        color: Color(HelperFile.blouseColor),
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              jsonObj["message"][0]
                                                      ["blouseCount"]
                                                  .toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                            )
                          ],
                        ),

                        //  dates
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 150,
                              // height: 100,
                              child: Card(
                                  // elevation: 0,
                                  // margin: EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Column(
                                children: [
                                  Center(
                                      child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(HelperFile.appColor)),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Order Date",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                  )),
                                  Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: Card(
                                          // color: Color(HelperFile.appColor),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(
                                                getDateFormat(jsonObj["message"]
                                                        [0]["orderDate"]
                                                    .toString()),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(
                                                      HelperFile.appColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                            ),
                            SizedBox(
                              width: 150,
                              // height: 100,
                              child: Card(
                                  // elevation: 0,
                                  // margin: EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Column(
                                children: [
                                  Center(
                                      child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Color(HelperFile.appColor)),
                                    child: Center(
                                        child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Delivery Date",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )),
                                  )),
                                  Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                        height: 100,
                                        width: double.infinity,
                                        child: Card(
                                          // color: Color(HelperFile.appColor),
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(
                                                getDateFormat(jsonObj["message"]
                                                        [0]["deliveryDate"]
                                                    .toString()),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(
                                                      HelperFile.appColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          color: Color(HelperFile.appColor),
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Center(
                              child: Text(
                                "Salwar Dress Image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: int.parse(
                              jsonObj["message"][0]["salwarCount"].toString()),
                          itemBuilder: (context, index) {
                            if (int.parse(jsonObj["message"][0]["salwarCount"]
                                    .toString()) ==
                                0) {
                                  
                              return Container(
                                child: Text("no data"),
                              );

                            } else {
                              return Container(
                                margin: EdgeInsets.all(10),
                                child: Card(
                                  child: Column(
                                    children: [
                                      Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(jsonObj["message"][0]
                                                      ["salwarData"][index]
                                                  ["salwarOrderId"]
                                              .toString()),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child:
                                                          Text("Dress Image"),
                                                    ),
                                                  ),
                                                  Image.memory(
                                                    getImageView(jsonObj[
                                                                    "message"][
                                                                0]["salwarData"]
                                                            [
                                                            index]["dressImage"]
                                                        .toString()),
                                                  ),
                                                ],
                                              )),
                                          SizedBox(
                                              width: 150,
                                              height: 150,
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                          "Stitched Image"),
                                                    ),
                                                  ),
                                                  Image.memory(
                                                    getImageView(jsonObj["message"]
                                                                        [0][
                                                                    "salwarData"]
                                                                [index][
                                                            "stichedDressImage"]
                                                        .toString()),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),

// don`t touch right now!!!
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          color: Color(HelperFile.appColor),
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(18),
                            child: Center(
                              child: Text(
                                "Blouse Dress Image",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: int.parse(jsonObj["message"][0]
                                    ["blouseCount"]
                                .toString()),
                            itemBuilder: (context, index) {
                              if (int.parse(jsonObj["message"][0]["blouseCount"]
                                      .toString()) ==
                                  0) {
                                return Center(
                                  child: Text("Blouse Image Not Yet Added."),
                                );
                              } else {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(jsonObj["message"][0]
                                                        ["blouseData"][index]
                                                    ["blouseOrderId"]
                                                .toString()),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                                width: 150,
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child:
                                                            Text("Dress Image"),
                                                      ),
                                                    ),
                                                    Image.memory(
                                                      getImageView(jsonObj[
                                                                      "message"]
                                                                  [
                                                                  0]["blouseData"]
                                                              [
                                                              index]["dressImage"]
                                                          .toString()),
                                                    ),
                                                  ],
                                                )),
                                            SizedBox(
                                                width: 150,
                                                height: 150,
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Text(
                                                            "Stitched Image"),
                                                      ),
                                                    ),
                                                    Image.memory(
                                                      getImageView(jsonObj["message"]
                                                                          [0][
                                                                      "blouseData"]
                                                                  [index][
                                                              "stichedDressImage"]
                                                          .toString()),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),

                        SizedBox(
                          height: 25.0,
                        ),

                        //  finalAmount
                        Container(
                            width: double.infinity,
                            color: Color(HelperFile.appColor),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Final Amount",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    " ₹ " +
                                        jsonObj["message"][0]["finalAmount"]
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ))
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ));
  }
}
