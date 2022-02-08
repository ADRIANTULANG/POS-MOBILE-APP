import 'dart:convert';

import 'package:get/get.dart';

List<TransactionDetails> transactionDetailsFromJson(String str) =>
    List<TransactionDetails>.from(
        json.decode(str).map((x) => TransactionDetails.fromJson(x)));

String transactionDetailsToJson(List<TransactionDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionDetails {
  TransactionDetails({
    required this.ordernumber,
    required this.itemId,
    required this.itemName,
    required this.itemBarcode,
    required this.itemPrice,
    required this.itemHasVariants,
    required this.itemCategoryName,
    required this.itemQuantity,
    required this.itemDiscount,
    required this.itemDiscountType,
    required this.variantId,
    required this.variantName,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantQuantity,
    required this.variantDiscount,
    required this.variantDiscountType,
  });

  String ordernumber;
  int itemId;
  String itemName;
  String itemBarcode;
  String itemPrice;
  int itemHasVariants;
  String itemCategoryName;
  int itemQuantity;
  String itemDiscount;
  String itemDiscountType;
  int variantId;
  String variantName;
  String variantPrice;
  int variantMainitemId;
  int variantQuantity;
  String variantDiscount;
  String variantDiscountType;

  factory TransactionDetails.fromJson(Map<String, dynamic> json) =>
      TransactionDetails(
        ordernumber: json["ordernumber"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemBarcode: json["item_barcode"],
        itemPrice: json["item_price"],
        itemHasVariants: json["item_has_variants"],
        itemCategoryName: json["item_category_name"],
        itemQuantity: json["item_quantity"],
        itemDiscount: json["item_discount"],
        itemDiscountType: json["item_discount_type"],
        variantId: json["variant_id"] ?? 0,
        variantName: json["variant_name"] ?? "",
        variantPrice: json["variant_price"] ?? "0.0",
        variantMainitemId: json["variant_mainitem_id"] ?? 0,
        variantQuantity: json["variant_quantity"] ?? 0,
        variantDiscount: json["variant_discount"] ?? "0.0",
        variantDiscountType: json["variant_discount_type"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ordernumber": ordernumber,
        "item_id": itemId,
        "item_name": itemName,
        "item_barcode": itemBarcode,
        "item_price": itemPrice,
        "item_has_variants": itemHasVariants,
        "item_category_name": itemCategoryName,
        "item_quantity": itemQuantity,
        "item_discount": itemDiscount,
        "item_discount_type": itemDiscountType,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_price": variantPrice,
        "variant_mainitem_id": variantMainitemId,
        "variant_quantity": variantQuantity,
        "variant_discount": variantDiscount,
        "variant_discount_type": variantDiscountType,
      };
}

List<FinalTransactionModel> finalTransactionModelFromJson(String str) =>
    List<FinalTransactionModel>.from(
        json.decode(str).map((x) => FinalTransactionModel.fromJson(x)));

String finalTransactionModelToJson(List<FinalTransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FinalTransactionModel {
  FinalTransactionModel({
    required this.ordernumber,
    required this.itemId,
    required this.itemName,
    required this.itemBarcode,
    required this.itemPrice,
    required this.itemHasVariants,
    required this.itemCategoryName,
    required this.itemDiscount,
    required this.itemDiscountType,
    required this.itemQuantity,
    required this.itemListOfVariants,
    required this.checkboxbool,
  });

  String ordernumber;
  int itemId;
  String itemName;
  String itemBarcode;
  String itemPrice;
  int itemHasVariants;
  String itemCategoryName;
  String itemDiscount;
  String itemDiscountType;
  int itemQuantity;
  RxBool checkboxbool;
  List<ItemListOfVariantHistory> itemListOfVariants;

  factory FinalTransactionModel.fromJson(Map<String, dynamic> json) =>
      FinalTransactionModel(
        checkboxbool: false.obs,
        ordernumber: json["ordernumber"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemBarcode: json["item_barcode"],
        itemPrice: json["item_price"],
        itemHasVariants: json["item_has_variants"],
        itemCategoryName: json["item_category_name"],
        itemDiscount: json["item_Discount"],
        itemDiscountType: json["item_Discount_type"],
        itemQuantity: json["itemQuantity"],
        itemListOfVariants: List<ItemListOfVariantHistory>.from(
            json["item_list_of_variants"]
                .map((x) => ItemListOfVariantHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ordernumber": ordernumber,
        "checkboxbool": checkboxbool,
        "item_id": itemId,
        "item_name": itemName,
        "item_barcode": itemBarcode,
        "item_price": itemPrice,
        "item_has_variants": itemHasVariants,
        "item_category_name": itemCategoryName,
        "item_Discount": itemDiscount,
        "item_Discount_type": itemDiscountType,
        "itemQuantity": itemQuantity,
        "item_list_of_variants":
            List<dynamic>.from(itemListOfVariants.map((x) => x.toJson())),
      };
}

class ItemListOfVariantHistory {
  ItemListOfVariantHistory({
    required this.ordernumber,
    required this.variantId,
    required this.variantName,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantDiscount,
    required this.variantDiscountType,
    required this.variantQuantity,
    required this.variantBoolean,
  });

  int variantId;
  String ordernumber;
  String variantName;
  String variantPrice;
  int variantMainitemId;
  String variantDiscount;
  String variantDiscountType;
  int variantQuantity;
  RxBool variantBoolean;

  factory ItemListOfVariantHistory.fromJson(Map<String, dynamic> json) =>
      ItemListOfVariantHistory(
        variantBoolean: false.obs,
        ordernumber: json["ordernumber"],
        variantId: json["variant_id"],
        variantName: json["variant_name"],
        variantPrice: json["variant_price"],
        variantMainitemId: json["variant_mainitem_id"],
        variantDiscount: json["variant_discount"],
        variantDiscountType: json["variant_discount_type"],
        variantQuantity: json["variant_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "ordernumber": ordernumber,
        "variantBoolean": variantBoolean,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_price": variantPrice,
        "variant_mainitem_id": variantMainitemId,
        "variant_discount": variantDiscount,
        "variant_discount_type": variantDiscountType,
        "variant_quantity": variantQuantity,
      };
}

List<InstallmentDetails> installmentDetailsFromJson(String str) =>
    List<InstallmentDetails>.from(
        json.decode(str).map((x) => InstallmentDetails.fromJson(x)));

String installmentDetailsToJson(List<InstallmentDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InstallmentDetails {
  InstallmentDetails({
    required this.installmentId,
    required this.ordernumber,
    required this.daysOfInstallment,
    required this.installmentPercentValue,
    required this.storeid,
  });

  int installmentId;
  String ordernumber;
  int daysOfInstallment;
  String installmentPercentValue;
  int storeid;

  factory InstallmentDetails.fromJson(Map<String, dynamic> json) =>
      InstallmentDetails(
        installmentId: json["installment_id"],
        ordernumber: json["ordernumber"],
        daysOfInstallment: json["days_of_installment"],
        installmentPercentValue: json["installment_percent_value"],
        storeid: json["storeid"],
      );

  Map<String, dynamic> toJson() => {
        "installment_id": installmentId,
        "ordernumber": ordernumber,
        "days_of_installment": daysOfInstallment,
        "installment_percent_value": installmentPercentValue,
        "storeid": storeid,
      };
}

List<ItemDetailsForRefund> itemDetailsForRefundFromJson(String str) =>
    List<ItemDetailsForRefund>.from(
        json.decode(str).map((x) => ItemDetailsForRefund.fromJson(x)));

String itemDetailsForRefundToJson(List<ItemDetailsForRefund> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemDetailsForRefund {
  ItemDetailsForRefund({
    required this.itemCount,
  });

  String itemCount;

  factory ItemDetailsForRefund.fromJson(Map<String, dynamic> json) =>
      ItemDetailsForRefund(
        itemCount: json["item_count"],
      );

  Map<String, dynamic> toJson() => {
        "item_count": itemCount,
      };
}

List<VariantDetailsForRefund> variantDetailsForRefundFromJson(String str) =>
    List<VariantDetailsForRefund>.from(
        json.decode(str).map((x) => VariantDetailsForRefund.fromJson(x)));

String variantDetailsForRefundToJson(List<VariantDetailsForRefund> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VariantDetailsForRefund {
  VariantDetailsForRefund({
    required this.variantCount,
  });

  String variantCount;

  factory VariantDetailsForRefund.fromJson(Map<String, dynamic> json) =>
      VariantDetailsForRefund(
        variantCount: json["variant_count"],
      );

  Map<String, dynamic> toJson() => {
        "variant_count": variantCount,
      };
}

List<Ordernumberdetails> ordernumberdetailsFromJson(String str) =>
    List<Ordernumberdetails>.from(
        json.decode(str).map((x) => Ordernumberdetails.fromJson(x)));

String ordernumberdetailsToJson(List<Ordernumberdetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ordernumberdetails {
  Ordernumberdetails({
    required this.orderid,
    required this.ordernumber,
    required this.orderUserid,
    required this.orderPaymentType,
    required this.orderStoreId,
    required this.datetime,
    required this.additionalCheckoutDiscount,
    required this.additionalCheckoutDiscountType,
    required this.orderTotalAmount,
    required this.orderDateCreated,
  });

  int orderid;
  String ordernumber;
  int orderUserid;
  String orderPaymentType;
  String orderStoreId;
  DateTime datetime;
  String additionalCheckoutDiscount;
  String additionalCheckoutDiscountType;
  String orderTotalAmount;
  String orderDateCreated;

  factory Ordernumberdetails.fromJson(Map<String, dynamic> json) =>
      Ordernumberdetails(
        orderid: json["orderid"],
        ordernumber: json["ordernumber"],
        orderUserid: json["order_userid"],
        orderPaymentType: json["order_payment_type"],
        orderStoreId: json["order_store_id"],
        datetime: DateTime.parse(json["datetime"]),
        additionalCheckoutDiscount: json["additional_checkout_discount"],
        additionalCheckoutDiscountType:
            json["additional_checkout_discount_type"],
        orderTotalAmount: json["order_total_amount"],
        orderDateCreated: json["order_date_created"],
      );

  Map<String, dynamic> toJson() => {
        "orderid": orderid,
        "ordernumber": ordernumber,
        "order_userid": orderUserid,
        "order_payment_type": orderPaymentType,
        "order_store_id": orderStoreId,
        "datetime": datetime.toIso8601String(),
        "additional_checkout_discount": additionalCheckoutDiscount,
        "additional_checkout_discount_type": additionalCheckoutDiscountType,
        "order_total_amount": orderTotalAmount,
        "order_date_created": orderDateCreated,
      };
}
