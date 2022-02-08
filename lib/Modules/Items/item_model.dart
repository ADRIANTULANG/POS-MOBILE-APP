import 'dart:convert';

import 'package:get/get.dart';

List<ItemsNew> ItemsNewFromJson(String str) =>
    List<ItemsNew>.from(json.decode(str).map((x) => ItemsNew.fromJson(x)));

String ItemsNewToJson(List<ItemsNew> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemsNew {
  ItemsNew({
    required this.itemId,
    required this.itemName,
    required this.itemCategoryId,
    required this.itemCost,
    required this.itemBarcode,
    required this.item_category_name,
    required this.itemPrice,
    required this.itemCount,
    required this.itemHasVariants,
    required this.item_Image,
    required this.ItemsNewtoreId,
    required this.itemBool,
    required this.item_discount,
    required this.item_discount_type,
  });

  int itemId;
  String item_discount;
  String item_discount_type;
  String itemName;
  String item_Image;
  int itemCategoryId;
  RxBool itemBool;
  String itemCost;
  String item_category_name;
  String itemBarcode;
  String itemPrice;
  String itemCount;
  int itemHasVariants;
  int ItemsNewtoreId;

  factory ItemsNew.fromJson(Map<String, dynamic> json) => ItemsNew(
        item_discount: json["item_discount"],
        item_discount_type: json["item_discount_type"],
        itemId: json["item_id"],
        item_Image: json["item_Image"],
        itemBool: false.obs,
        itemName: json["item_name"],
        item_category_name: json["item_category_name"],
        itemCategoryId: json["item_category_id"],
        itemCost: json["item_cost"],
        itemBarcode: json["item_barcode"],
        itemPrice: json["item_price"],
        itemCount: json["item_count"],
        itemHasVariants: json["item_has_variants"],
        ItemsNewtoreId: json["item_store_id"],
      );

  Map<String, dynamic> toJson() => {
        "item_discount": item_discount,
        "item_discount_type": item_discount_type,
        "item_id": itemId,
        "item_Image": item_Image,
        "itemBool": itemBool,
        "item_category_name": item_category_name,
        "item_name": itemName,
        "item_category_id": itemCategoryId,
        "item_cost": itemCost,
        "item_barcode": itemBarcode,
        "item_price": itemPrice,
        "item_count": itemCount,
        "item_has_variants": itemHasVariants,
        "item_store_id": ItemsNewtoreId,
      };
}

List<VariantListInUpdate> variantListInUpdateFromJson(String str) =>
    List<VariantListInUpdate>.from(
        json.decode(str).map((x) => VariantListInUpdate.fromJson(x)));

String variantListInUpdateToJson(List<VariantListInUpdate> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VariantListInUpdate {
  VariantListInUpdate({
    required this.variantId,
    required this.variantName,
    required this.variantCount,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantStoreId,
    required this.variant_discount,
    required this.variant_discount_type,
  });

  int variantId;
  String variant_discount;
  String variant_discount_type;
  String variantName;
  String variantCount;
  String variantPrice;
  int variantMainitemId;
  int variantStoreId;

  factory VariantListInUpdate.fromJson(Map<String, dynamic> json) =>
      VariantListInUpdate(
        variant_discount: json["variant_discount"],
        variant_discount_type: json["variant_discount_type"],
        variantId: json["variant_id"],
        variantName: json["variant_name"],
        variantCount: json["variant_count"],
        variantPrice: json["variant_price"],
        variantMainitemId: json["variant_mainitem_id"],
        variantStoreId: json["variant_store_id"],
      );

  Map<String, dynamic> toJson() => {
        "variant_discount": variant_discount,
        "variant_discount_type": variant_discount_type,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_count": variantCount,
        "variant_price": variantPrice,
        "variant_mainitem_id": variantMainitemId,
        "variant_store_id": variantStoreId,
      };
}
