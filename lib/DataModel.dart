// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    DataModel({
        this.cusMobNo,
        this.cusId,
    });

    
    String? cusMobNo;
    String? cusId;

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        cusMobNo: json["cusMobNo"],
        cusId: json["cusId"],
    );

    Map<String, dynamic> toJson() => {
        "cusMobNo": cusMobNo,
        "cusId": cusId,
    };
}
