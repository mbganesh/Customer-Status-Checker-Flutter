import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDemo extends StatefulWidget {
  const ApiDemo({Key? key}) : super(key: key);

  @override
  _ApiDemoState createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  Future getApiData() async {
    var response =
        await http.get(Uri.https("jsonplaceholder.typicode.com", "posts"));
    var jsonData = jsonDecode(response.body);

    print(jsonData); // jsonArr
    print("jsonData");

    List<ApiData> datas = [];

    for (var item in jsonData) {
      ApiData data =
          ApiData(item["userId"], item["id"], item["title"], item["body"]);
      datas.add(data);
    }

    print(datas.length);

    return datas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Api Demo"),
          ),
        ),
        body: Container(
            child: Card(
          elevation: 25,
          // margin: EdgeInsets.all(5),

          child: FutureBuilder<dynamic>(
            future: getApiData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(border: Border.all(width: 2)),
                      child: ListTile(
                        leading: Text((index + 1).toString()),
                        title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].body),
                        contentPadding: EdgeInsets.all(4),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )));
  }
}

class ApiData {
  final int userId, id;
  final String title, body;
  ApiData(this.userId, this.id, this.title, this.body);
}
