// To parse this JSON data, do
//
//     final storeDataModel = storeDataModelFromJson(jsonString);
import 'package:get/get.dart';
import 'dart:convert';

List<StoreDataModel> storeDataModelFromJson(String str) =>
    List<StoreDataModel>.from(
        json.decode(str).map((x) => StoreDataModel.fromJson(x)));

String storeDataModelToJson(List<StoreDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreDataModel {
  StoreDataModel({
    required this.itemId,
    required this.itemBarcode,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemCategory,
    required this.itemQuantity,
    required this.itemImage,
    required this.itemVariantSelected,
    required this.itemAdditionalPrice,
    required this.itemVariants,
    required this.itemCost,
    required this.itemDiscount,
    required this.itemCount,
    required this.itemDiscountType,
  });

  int itemId;
  String itemBarcode;
  String itemName;
  String itemCount;
  String itemDescription;
  RxDouble itemPrice;
  String itemCategory;
  RxInt itemQuantity;
  String itemImage;
  String itemDiscountType;
  List<ItemVariant> itemVariants;
  RxString itemVariantSelected;
  RxString itemAdditionalPrice;
  RxString itemCost;
  RxString itemDiscount;

  factory StoreDataModel.fromJson(Map<String, dynamic> json) => StoreDataModel(
        itemCost: json["itemCost"].toString().obs,
        itemDiscount: json["itemDiscount"].toString().obs,
        itemCount: json["itemCount"],
        itemBarcode: json["itemBarcode"],
        itemDiscountType: json["itemDiscountType"],
        itemId: json["itemID"],
        itemVariantSelected: json["itemVariantSelected"].toString().obs,
        itemAdditionalPrice: json["itemAdditionalPrice"].toString().obs,
        itemName: json["itemName"],
        itemDescription: json["itemDescription"],
        itemPrice: double.parse(json["itemPrice"]).obs,
        itemCategory: json["itemCategory"],
        itemQuantity: int.parse(json["itemQuantity"].toString()).obs,
        itemImage: json["itemImage"],
        itemVariants: List<ItemVariant>.from(
            json["itemVariants"].map((x) => ItemVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "itemCount": itemCount,
        "itemBarcode": itemBarcode,
        "itemDiscountType": itemDiscountType,
        "itemDiscount": itemDiscount,
        "itemCost": itemCost,
        "itemID": itemId,
        "itemVariantSelected": itemVariantSelected,
        "itemAdditionalPrice": itemAdditionalPrice,
        "itemName": itemName,
        "itemDescription": itemDescription,
        "itemPrice": itemPrice,
        "itemCategory": itemCategory,
        "itemQuantity": itemQuantity,
        "itemImage": itemImage,
        "itemVariants": List<dynamic>.from(itemVariants.map((x) => x.toJson())),
      };
}

class ItemVariant {
  ItemVariant({
    required this.variantID,
    required this.variantName,
    required this.variantPrice,
    required this.variantCount,
    required this.variantQunatity,
    required this.variantBool,
  });
  String variantID;
  String variantName;
  String variantPrice;
  String variantCount;
  RxInt variantQunatity;
  RxBool variantBool;

  factory ItemVariant.fromJson(Map<String, dynamic> json) => ItemVariant(
        variantBool: false.obs,
        variantID: json["variantID"],
        variantName: json["variantName"],
        variantPrice: json["variantPrice"],
        variantCount: json["variantCount"],
        variantQunatity: int.parse(json["variantQunatity"].toString()).obs,
      );

  Map<String, dynamic> toJson() => {
        "variantID": variantID,
        "variantBool": variantBool,
        "variantName": variantName,
        "variantPrice": variantPrice,
        "variantCount": variantCount,
        "variantQunatity": variantQunatity,
      };
}
