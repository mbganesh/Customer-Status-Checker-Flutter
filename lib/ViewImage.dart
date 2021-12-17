import 'dart:typed_data';

import 'package:ShivaneDesigning/HelperFile.dart';
import 'package:flutter/material.dart';

class ViewImage extends StatefulWidget {
  final Uint8List? image;

  const ViewImage({Key? key, @required this.image}) : super(key: key);

  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {

  Uint8List dataFromBase64String(String base64String) {
    final UriData? data = Uri.parse(base64String).data;
    return data!.contentAsBytes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Image"),
      ),
      body: Hero(
          tag: "salwar",
          child: widget.image != null
              ? Image.memory(widget.image!)
              : Image.memory(dataFromBase64String(HelperFile.no_image))),
    );
  }
}
