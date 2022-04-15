import 'dart:convert';

import 'package:get/get.dart';

List<ItemsModel> itemsModelFromJson(String str) =>
    List<ItemsModel>.from(json.decode(str).map((x) => ItemsModel.fromJson(x)));

String itemsModelToJson(List<ItemsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemsModel {
  ItemsModel({
    required this.variantId,
    required this.variantName,
    required this.variantCount,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantStoreId,
    required this.variant_discount,
    required this.variant_discount_type,
    required this.variant_barcode,
    required this.itemId,
    required this.itemName,
    required this.itemCategoryId,
    required this.itemCost,
    required this.itemBarcode,
    required this.itemPrice,
    required this.itemCount,
    required this.itemHasVariants,
    required this.itemStoreId,
    required this.itemCategoryName,
    required this.itemImage,
    required this.itemDiscount,
    required this.itemDiscount_type,
  });
  String itemDiscount;
  String itemDiscount_type;
  int variantId;
  String variantName;
  String variantCount;
  String variantPrice;
  String variant_discount;
  String variant_discount_type;
  String variant_barcode;
  int variantMainitemId;
  int variantStoreId;
  int itemId;
  String itemName;
  int itemCategoryId;
  String itemCost;
  String itemBarcode;
  String itemPrice;
  String itemCount;
  int itemHasVariants;
  int itemStoreId;
  String itemCategoryName;
  String itemImage;

  factory ItemsModel.fromJson(Map<String, dynamic> json) => ItemsModel(
        itemDiscount: json["item_discount"] ?? "0",
        itemDiscount_type: json["item_discount_type"] ?? "0",
        variantId: json["variant_id"] ?? 0,
        variantName: json["variant_name"] ?? '',
        variantCount: json["variant_count"] ?? '',
        variantPrice: json["variant_price"] ?? '',
        variant_barcode: json["variant_barcode"] ?? '',
        variant_discount: json["variant_discount"] ?? '0',
        variant_discount_type: json["variant_discount_type"] ?? '',
        variantMainitemId: json["variant_mainitem_id"] ?? 0,
        variantStoreId: json["variant_store_id"] ?? 0,
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemCategoryId: json["item_category_id"],
        itemCost: json["item_cost"],
        itemBarcode: json["item_barcode"],
        itemPrice: json["item_price"],
        itemCount: json["item_count"],
        itemHasVariants: json["item_has_variants"],
        itemStoreId: json["item_store_id"],
        itemCategoryName: json["item_category_name"],
        itemImage: json["item_Image"],
      );

  Map<String, dynamic> toJson() => {
        "item_discount": itemDiscount,
        "item_discount_type": itemDiscount_type,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_count": variantCount,
        "variant_price": variantPrice,
        "variant_barcode": variant_barcode,
        "variant_mainitem_id": variantMainitemId,
        "variant_store_id": variantStoreId,
        "item_id": itemId,
        "item_name": itemName,
        "item_category_id": itemCategoryId,
        "item_cost": itemCost,
        "item_barcode": itemBarcode,
        "item_price": itemPrice,
        "item_count": itemCount,
        "item_has_variants": itemHasVariants,
        "item_store_id": itemStoreId,
        "item_category_name": itemCategoryName,
        "item_Image": itemImage,
      };
}

List<FinalItemsList> finalItemsListFromJson(String str) =>
    List<FinalItemsList>.from(
        json.decode(str).map((x) => FinalItemsList.fromJson(x)));

String finalItemsListToJson(List<FinalItemsList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinalItemsList {
  FinalItemsList({
    required this.itemQuantity,
    required this.itemId,
    required this.itemName,
    required this.itemCategoryId,
    required this.itemCost,
    required this.itemBarcode,
    required this.itemPrice,
    required this.itemCount,
    required this.itemHasVariants,
    required this.itemStoreId,
    required this.itemImage,
    required this.itemCategoryName,
    required this.itemListOfVariants,
    required this.item_Discount,
    required this.item_Discount_type,
  });
  String item_Discount;
  String item_Discount_type;
  RxInt itemQuantity;
  int itemId;
  String itemName;
  int itemCategoryId;
  String itemCost;
  String itemBarcode;
  RxString itemPrice;
  String itemCount;
  int itemHasVariants;
  int itemStoreId;
  String itemImage;
  String itemCategoryName;
  List<ItemListOfVariant> itemListOfVariants;

  factory FinalItemsList.fromJson(Map<String, dynamic> json) => FinalItemsList(
        itemQuantity: int.parse(json["itemQuantity"].toString()).obs,
        itemId: json["item_id"],
        itemName: json["item_name"],
        item_Discount: json["item_Discount"],
        item_Discount_type: json["item_Discount_type"],
        itemCategoryId: json["item_category_id"],
        itemCost: json["item_cost"],
        itemBarcode: json["item_barcode"],
        itemPrice: json["item_price"].toString().obs,
        itemCount: json["item_count"],
        itemHasVariants: json["item_has_variants"],
        itemStoreId: json["item_store_id"],
        itemImage: json["item_Image"],
        itemCategoryName: json["item_category_name"],
        itemListOfVariants: List<ItemListOfVariant>.from(
            json["item_list_of_variants"]
                .map((x) => ItemListOfVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "itemQuantity": itemQuantity,
        "item_id": itemId,
        "item_Discount": item_Discount,
        "item_Discount_type": item_Discount_type,
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
        "item_list_of_variants":
            List<dynamic>.from(itemListOfVariants.map((x) => x.toJson())),
      };
}

class ItemListOfVariant {
  ItemListOfVariant({
    required this.variantShowTextField,
    required this.variantQuantity,
    required this.variantId,
    required this.variantName,
    required this.variantCount,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantStoreId,
    required this.variant_discount,
    required this.variant_barcode,
    required this.variant_discount_type,
  });
  RxInt variantQuantity;
  RxBool variantShowTextField;
  int variantId;
  String variantName;
  String variantCount;
  String variantPrice;
  String variant_discount;
  String variant_barcode;
  String variant_discount_type;
  int variantMainitemId;
  int variantStoreId;

  factory ItemListOfVariant.fromJson(Map<String, dynamic> json) =>
      ItemListOfVariant(
        variantQuantity: int.parse(json["variantQuantity"].toString()).obs,
        variantShowTextField: false.obs,
        variantId: json["variant_id"],
        variant_barcode: json["variant_barcode"],
        variantName: json["variant_name"],
        variant_discount: json["variant_discount"],
        variant_discount_type: json["variant_discount_type"],
        variantCount: json["variant_count"],
        variantPrice: json["variant_price"],
        variantMainitemId: json["variant_mainitem_id"],
        variantStoreId: json["variant_store_id"],
      );

  Map<String, dynamic> toJson() => {
        "variant_barcode": variant_barcode,
        "variantQuantity": variantQuantity,
        "variantShowTextField": variantShowTextField,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_discount": variant_discount,
        "variant_discount_type": variant_discount_type,
        "variant_count": variantCount,
        "variant_price": variantPrice,
        "variant_mainitem_id": variantMainitemId,
        "variant_store_id": variantStoreId,
      };
}
