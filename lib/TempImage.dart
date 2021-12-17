import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class TempImage extends StatefulWidget {
  const TempImage({Key? key}) : super(key: key);

  @override
  _TempImageState createState() => _TempImageState();
}

bool isSitValid = false;

class _TempImageState extends State<TempImage> {
  Uint8List dataFromBase64String(String base64String) {
    final UriData? data = Uri.parse(base64String).data;
    isSitValid = data?.isBase64 ?? false;
    print(isSitValid);
    return data!.contentAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temp Image"),
      ),
      body: Center(
          child: isSitValid
              ? Image.memory(dataFromBase64String(HelperFile.no_image))
              : CircularProgressIndicator()),
    );
  }
}
