import 'dart:convert';

import 'package:get/get.dart';

List<CartList> cartListFromJson(String str) =>
    List<CartList>.from(json.decode(str).map((x) => CartList.fromJson(x)));

String cartListToJson(List<CartList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartList {
  CartList({
    required this.itemId,
    required this.itemName,
    required this.itemCategoryId,
    required this.itemCost,
    required this.item_Quantity,
    required this.itemBarcode,
    required this.itemPrice,
    required this.itemCount,
    required this.itemHasVariants,
    required this.itemStoreId,
    required this.itemImage,
    required this.itemCategoryName,
    required this.itemVariantList,
    required this.item_Discount,
    required this.item_discount_type,
    required this.item_Boolean,
  });
  String item_Discount;
  String item_discount_type;
  int itemId;
  RxInt item_Quantity;
  String itemName;
  int itemCategoryId;
  String itemCost;
  String itemBarcode;
  String itemPrice;
  String itemCount;
  int itemHasVariants;
  int itemStoreId;
  String itemImage;
  String itemCategoryName;
  RxBool item_Boolean;
  List<ItemVariantList>? itemVariantList;

  factory CartList.fromJson(Map<String, dynamic> json) => CartList(
        item_Boolean: false.obs,
        item_Discount:
            json["item_Discount"] == null ? 0 : json["item_Discount"],
        item_discount_type: json["item_discount_type"] == null
            ? ""
            : json["item_discount_type"],
        item_Quantity: json["item_Quantity"] == null
            ? 0.obs
            : int.parse((json["item_Quantity"]).toString()).obs,
        itemId: json["item_id"] == null ? 0 : json["item_id"],
        itemName: json["item_name"] == null ? "" : json["item_name"],
        itemCategoryId:
            json["item_category_id"] == null ? 0 : json["item_category_id"],
        itemCost: json["item_cost"] == null ? "" : json["item_cost"],
        itemBarcode: json["item_barcode"] == null ? "" : json["item_barcode"],
        itemPrice: json["item_price"] == null ? "" : json["item_price"],
        itemCount: json["item_count"] == null ? "" : json["item_count"],
        itemHasVariants:
            json["item_has_variants"] == null ? 0 : json["item_has_variants"],
        itemStoreId: json["item_store_id"] == null ? 0 : json["item_store_id"],
        itemImage: json["item_Image"] == null ? "" : json["item_Image"],
        itemCategoryName: json["item_category_name"] == null
            ? ""
            : json["item_category_name"],
        itemVariantList: json["item_variant_list"] == null
            ? []
            : List<ItemVariantList>.from(json["item_variant_list"]
                .map((x) => ItemVariantList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "item_Boolean": item_Boolean,
        "item_Discount": item_Discount,
        "item_discount_type": item_discount_type,
        "item_id": itemId,
        "item_Quantity": item_Quantity,
        "item_name": itemName,
        "item_category_id": itemCategoryId,
        "item_cost": itemCost,
        "item_barcode": itemBarcode,
        "item_price": itemPrice,
        "item_count": itemCount,
        "item_has_variants": itemHasVariants,
        "item_store_id": itemStoreId,
        "item_Image": itemImage,
        "item_category_name": itemCategoryName,
        "item_variant_list":
            List<dynamic>.from(itemVariantList!.map((x) => x.toJson())),
      };
}

class ItemVariantList {
  ItemVariantList({
    required this.variantId,
    required this.variant_Quantity,
    required this.variantName,
    required this.variantCount,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantStoreId,
    required this.variant_discount,
    required this.variant_discount_type,
    required this.variant_Boolean,
  });
  RxInt variant_Quantity;
  RxBool variant_Boolean;
  int variantId;
  String variantName;
  String variantCount;
  String variantPrice;
  String variant_discount;
  String variant_discount_type;
  int variantMainitemId;
  int variantStoreId;

  factory ItemVariantList.fromJson(Map<String, dynamic> json) =>
      ItemVariantList(
        variant_Boolean: false.obs,
        variant_discount:
            json["variant_discount"] == null ? 0 : json["variant_discount"],
        variant_discount_type: json["variant_discount_type"] == null
            ? ""
            : json["variant_discount_type"],
        variant_Quantity: json["variant_Quantity"] == null
            ? 0.obs
            : int.parse(json["variant_Quantity"].toString()).obs,
        variantId: json["variant_id"] == null ? 0 : json["variant_id"],
        variantName: json["variant_name"] == null ? "" : json["variant_name"],
        variantCount:
            json["variant_count"] == null ? "" : json["variant_count"],
        variantPrice:
            json["variant_price"] == null ? "" : json["variant_price"],
        variantMainitemId: json["variant_mainitem_id"] == null
            ? 0
            : json["variant_mainitem_id"],
        variantStoreId:
            json["variant_store_id"] == null ? 0 : json["variant_store_id"],
      );

  Map<String, dynamic> toJson() => {
        "variant_Boolean": variant_Boolean,
        "variant_discount": variant_discount,
        "variant_discount_type": variant_discount_type,
        "variant_Quantity": variant_Quantity,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_count": variantCount,
        "variant_price": variantPrice,
        "variant_mainitem_id": variantMainitemId,
        "variant_store_id": variantStoreId,
      };
}
