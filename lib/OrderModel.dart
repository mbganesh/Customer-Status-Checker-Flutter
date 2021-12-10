// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    OrderModel({
        this.cusMobNo,
        this.cusId,
        this.orderId,
    });

    String? cusMobNo;
    String? cusId;
    String? orderId;

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        cusMobNo: json["cusMobNo"],
        cusId: json["cusId"],
        orderId: json["orderID"],
    );

    Map<String, dynamic> toJson() => {
        "cusMobNo": cusMobNo,
        "cusId": cusId,
        "orderID": orderId,
    };
}
