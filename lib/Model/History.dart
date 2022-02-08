// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);
import 'dart:convert';

import 'package:get/get.dart';

List<History> historyFromJson(String str) =>
    List<History>.from(json.decode(str).map((x) => History.fromJson(x)));

String historyToJson(List<History> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class History {
  History(
      {required this.purchasedId,
      required this.customername,
      required this.paymentType,
      required this.monthsToPay,
      required this.transactionNumber,
      required this.itemList,
      required this.totalPrice,
      required this.timeStamp,
      required this.originalPrice,
      required this.yearMonthDate,
      required this.boolean});

  String purchasedId;

  String paymentType;
  String monthsToPay;
  String originalPrice;
  String transactionNumber;
  List<ItemList> itemList;
  String totalPrice;
  DateTime timeStamp;
  String yearMonthDate;
  String customername;
  RxBool boolean;

  factory History.fromJson(Map<String, dynamic> json) => History(
        boolean: false.obs,
        purchasedId: json["purchasedID"],
        customername: json["customername"],
        paymentType: json["paymentType"],
        monthsToPay: json["monthsToPay"],
        originalPrice: json["originalPrice"],
        transactionNumber: json["transactionNumber"],
        itemList: List<ItemList>.from(
            json["itemList"].map((x) => ItemList.fromJson(x))),
        totalPrice: json["totalPrice"],
        timeStamp: DateTime.parse(json["timeStamp"]),
        yearMonthDate: json["yearMonthDate"],
      );

  Map<String, dynamic> toJson() => {
        "boolean": boolean,
        "customername": customername,
        "purchasedID": purchasedId,
        "originalPrice": originalPrice,
        "paymentType": paymentType,
        "monthsToPay": monthsToPay,
        "transactionNumber": transactionNumber,
        "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "timeStamp": timeStamp.toIso8601String(),
        "yearMonthDate": yearMonthDate,
      };
}

class ItemList {
  ItemList({
    required this.itemId,
    required this.itemName,
    required this.itemDiscountType,
    required this.itemPrice,
    required this.itemDescription,
    required this.itemCategory,
    required this.itemQuantity,
    required this.itemSelectedVariants,
    required this.itemAdditionalPrice,
    required this.itemVariants,
    required this.itemDiscount,
    required this.itemCost,
    required this.itemBarcode,
  });

  int itemId;
  String itemBarcode;
  String itemName;
  String itemDiscountType;
  String itemPrice;
  String itemDiscount;
  String itemCost;
  String itemDescription;
  String itemCategory;
  String itemQuantity;
  String itemSelectedVariants;
  String itemAdditionalPrice;
  List<ItemVariant> itemVariants;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        itemId: json["itemID"],
        itemBarcode: json["itemBarcode"],
        itemName: json["itemName"],
        itemDiscountType: json["itemDiscountType"],
        itemDiscount: json["itemDiscount"],
        itemCost: json["itemCost"],
        itemPrice: json["itemPrice"],
        itemDescription: json["itemDescription"],
        itemCategory: json["itemCategory"],
        itemQuantity: json["itemQuantity"],
        itemSelectedVariants: json["itemSelectedVariants"],
        itemAdditionalPrice: json["itemAdditionalPrice"],
        itemVariants: List<ItemVariant>.from(
            json["itemVariants"].map((x) => ItemVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "itemDiscount": itemDiscount,
        "itemBarcode": itemBarcode,
        "itemCost": itemCost,
        "itemID": itemId,
        "itemDiscountType": itemDiscountType,
        "itemName": itemName,
        "itemPrice": itemPrice,
        "itemDescription": itemDescription,
        "itemCategory": itemCategory,
        "itemQuantity": itemQuantity,
        "itemSelectedVariants": itemSelectedVariants,
        "itemAdditionalPrice": itemAdditionalPrice,
        "itemVariants": List<dynamic>.from(itemVariants.map((x) => x.toJson())),
      };
}

class ItemVariant {
  ItemVariant({
    required this.variantID,
    required this.variantName,
    required this.variantPrice,
    required this.variantTotal,
    required this.variantQuantity,
  });
  String variantID;
  String variantName;
  String variantPrice;
  int variantTotal;
  String variantQuantity;

  factory ItemVariant.fromJson(Map<String, dynamic> json) => ItemVariant(
        variantName: json["variantName"],
        variantID: json["variantID"],
        variantPrice: json["variantPrice"],
        variantTotal: json["variantTotal"],
        variantQuantity: json["variantQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "variantID": variantID,
        "variantName": variantName,
        "variantPrice": variantPrice,
        "variantTotal": variantTotal,
        "variantQuantity": variantQuantity,
      };
}
