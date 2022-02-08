// To parse this JSON data, do
//
//     final printerModel = printerModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<PrinterModel> printerModelFromJson(String str) => List<PrinterModel>.from(
    json.decode(str).map((x) => PrinterModel.fromJson(x)));

String printerModelToJson(List<PrinterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrinterModel {
  PrinterModel({
    required this.address,
    required this.name,
    required this.connected,
    required this.type,
    required this.bools,
  });

  String address;
  String name;
  dynamic connected;
  int type;
  RxBool bools;

  factory PrinterModel.fromJson(Map<String, dynamic> json) => PrinterModel(
        address: json["address"],
        bools: false.obs,
        name: json["name"],
        connected: json["connected"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "bools": bools,
        "name": name,
        "connected": connected,
        "type": type,
      };
}
