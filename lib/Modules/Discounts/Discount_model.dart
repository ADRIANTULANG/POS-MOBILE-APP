import 'dart:convert';

import 'package:get/get.dart';

List<Discount> discountFromJson(String str) =>
    List<Discount>.from(json.decode(str).map((x) => Discount.fromJson(x)));

String discountToJson(List<Discount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Discount {
  Discount({
    required this.discountName,
    required this.discount,
    required this.discountType,
    required this.discountCreatorId,
    required this.discountStoreId,
    required this.discountId,
    required this.discountActive,
  });

  String discountName;
  String discount;
  RxString discountType;
  int discountCreatorId;
  int discountStoreId;
  int discountId;
  RxBool discountActive;

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        discountName: json["discount_name"],
        discount: json["discount"],
        discountType: json["discount_type"].toString().obs,
        discountCreatorId: json["discount_creator_id"],
        discountStoreId: json["discount_store_id"],
        discountId: json["discount_id"],
        discountActive: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "discount_name": discountName,
        "discountActive": discountActive,
        "discount": discount,
        "discount_type": discountType,
        "discount_creator_id": discountCreatorId,
        "discount_store_id": discountStoreId,
        "discount_id": discountId,
      };
}
