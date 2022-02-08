// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';
import 'package:get/get.dart';

List<Items> itemsFromJson(String str) =>
    List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
  Items({
    required this.itemBarcode,
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemCategory,
    required this.itemQuantity,
    required this.itemCount,
    required this.itemBool,
    required this.itemImage,
    required this.itemCost,
    required this.itemDiscount,
    required this.itemDiscountType,
  });

  int itemId;
  String itemDiscountType;
  String itemBarcode;
  String itemName;
  String itemDescription;
  RxDouble itemPrice;
  String itemCategory;
  RxInt itemQuantity;
  String itemCount;
  RxBool itemBool;
  String itemImage;
  String itemCost;
  String itemDiscount;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        itemDiscountType: json["itemDiscountType"],
        itemBarcode: json["itemBarcode"],
        itemId: json["itemID"],
        itemDiscount: json["itemDiscount"],
        itemName: json["itemName"],
        itemDescription: json["itemDescription"],
        itemPrice: double.parse(json["itemPrice"]).obs,
        itemCategory: json["itemCategory"],
        itemQuantity: int.parse(json["itemQuantity"].toString()).obs,
        itemCount: json["itemCount"],
        itemImage: json["itemImage"],
        itemBool: false.obs,
        itemCost: json["itemCost"],
      );

  Map<String, dynamic> toJson() => {
        "itemBarcode": itemBarcode,
        "itemDiscountType": itemDiscountType,
        "itemID": itemId,
        "itemDiscount": itemDiscount,
        "itemName": itemName,
        "itemDescription": itemDescription,
        "itemPrice": itemPrice,
        "itemCategory": itemCategory,
        "itemQuantity": itemQuantity,
        "itemCount": itemCount,
        "itemImage": itemImage,
        "itemBool": itemBool,
        "itemCost": itemCost,
      };
}
