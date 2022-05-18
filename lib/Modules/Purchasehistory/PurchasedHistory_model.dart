import 'dart:convert';

import 'package:get/get.dart';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(
    json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  HistoryModel({
    required this.orderid,
    required this.ordernumber,
    required this.orderUserid,
    required this.orderPaymentType,
    required this.orderStoreId,
    required this.datetime,
    required this.additionalCheckoutDiscount,
    required this.additionalCheckoutDiscountType,
    required this.installmentId,
    required this.daysOfInstallment,
    required this.installmentPercentValue,
    required this.boolean,
  });

  int orderid;
  String ordernumber;
  int orderUserid;
  String orderPaymentType;
  String orderStoreId;
  DateTime datetime;
  String additionalCheckoutDiscount;
  String additionalCheckoutDiscountType;
  dynamic installmentId;
  dynamic daysOfInstallment;
  dynamic installmentPercentValue;
  RxBool boolean;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        orderid: json["orderid"],
        ordernumber: json["ordernumber"].toString(),
        orderUserid: int.parse(json["order_userid"].toString()),
        orderPaymentType: json["order_payment_type"],
        orderStoreId: json["order_store_id"],
        datetime: DateTime.parse(json["datetime"]),
        additionalCheckoutDiscount: json["additional_checkout_discount"],
        additionalCheckoutDiscountType:
            json["additional_checkout_discount_type"],
        installmentId: json["installment_id"] ?? 0,
        daysOfInstallment: json["days_of_installment"] ?? 0,
        installmentPercentValue: json["installment_percent_value"] ?? 0,
        boolean: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "boolean": boolean,
        "orderid": orderid,
        "ordernumber": ordernumber,
        "order_userid": orderUserid,
        "order_payment_type": orderPaymentType,
        "order_store_id": orderStoreId,
        "datetime": datetime.toIso8601String(),
        "additional_checkout_discount": additionalCheckoutDiscount,
        "additional_checkout_discount_type": additionalCheckoutDiscountType,
        "installment_id": installmentId,
        "days_of_installment": daysOfInstallment,
        "installment_percent_value": installmentPercentValue,
      };
}

List<DailySalesForPrint> dailySalesForPrintFromJson(String str) =>
    List<DailySalesForPrint>.from(
        json.decode(str).map((x) => DailySalesForPrint.fromJson(x)));

String dailySalesForPrintToJson(List<DailySalesForPrint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DailySalesForPrint {
  DailySalesForPrint({
    required this.orderid,
    required this.ordernumber,
    required this.orderUserid,
    required this.orderPaymentType,
    required this.orderStoreId,
    required this.datetime,
    required this.additionalCheckoutDiscount,
    required this.additionalCheckoutDiscountType,
    required this.orderTotalAmount,
    required this.order_total_discount,
    required this.orderDateCreated,
    required this.daysOfInstallment,
    required this.installmentPercentValue,
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
  String order_total_discount;
  String orderDateCreated;
  int daysOfInstallment;
  String installmentPercentValue;

  factory DailySalesForPrint.fromJson(Map<String, dynamic> json) =>
      DailySalesForPrint(
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
        order_total_discount: json["order_total_discount"],
        orderDateCreated: json["order_date_created"],
        daysOfInstallment: json["days_of_installment"] ?? 0,
        installmentPercentValue: json["installment_percent_value"] ?? "0.0",
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
        "order_total_discount": order_total_discount,
        "order_date_created": orderDateCreated,
        "days_of_installment": daysOfInstallment,
        "installment_percent_value": installmentPercentValue,
      };
}

List<ExpensesDaily> expensesDailyFromJson(String str) =>
    List<ExpensesDaily>.from(
        json.decode(str).map((x) => ExpensesDaily.fromJson(x)));

String expensesDailyToJson(List<ExpensesDaily> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpensesDaily {
  ExpensesDaily({
    required this.expensesId,
    required this.expensesAmount,
    required this.expensesNote,
    required this.expensesDateCreated,
    required this.expensesStoreid,
    required this.expensesDateOnly,
  });

  int expensesId;
  String expensesAmount;
  String expensesNote;
  DateTime expensesDateCreated;
  String expensesStoreid;
  String expensesDateOnly;

  factory ExpensesDaily.fromJson(Map<String, dynamic> json) => ExpensesDaily(
        expensesId: json["expensesID"],
        expensesAmount: json["expenses_amount"],
        expensesNote: json["expenses_note"],
        expensesDateCreated: DateTime.parse(json["expenses_date_created"]),
        expensesStoreid: json["expenses_storeid"],
        expensesDateOnly: json["expenses_date_only"],
      );

  Map<String, dynamic> toJson() => {
        "expensesID": expensesId,
        "expenses_amount": expensesAmount,
        "expenses_note": expensesNote,
        "expenses_date_created": expensesDateCreated.toIso8601String(),
        "expenses_storeid": expensesStoreid,
        "expenses_date_only": expensesDateOnly,
      };
}

List<TotalCostMainItems> totalCostMainItemsFromJson(String str) =>
    List<TotalCostMainItems>.from(
        json.decode(str).map((x) => TotalCostMainItems.fromJson(x)));

String totalCostMainItemsToJson(List<TotalCostMainItems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalCostMainItems {
  TotalCostMainItems({
    required this.itemCost,
    required this.itemHasVariants,
    required this.itemQuantity,
  });

  String itemCost;
  int itemHasVariants;
  int itemQuantity;

  factory TotalCostMainItems.fromJson(Map<String, dynamic> json) =>
      TotalCostMainItems(
        itemCost: json["item_cost"],
        itemHasVariants: json["item_has_variants"],
        itemQuantity: json["item_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "item_cost": itemCost,
        "item_has_variants": itemHasVariants,
        "item_quantity": itemQuantity,
      };
}

List<TotalCostVariants> totalCostVariantsFromJson(String str) =>
    List<TotalCostVariants>.from(
        json.decode(str).map((x) => TotalCostVariants.fromJson(x)));

String totalCostVariantsToJson(List<TotalCostVariants> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalCostVariants {
  TotalCostVariants({
    required this.variantCost,
    required this.variantQuantity,
  });

  String variantCost;
  int variantQuantity;

  factory TotalCostVariants.fromJson(Map<String, dynamic> json) =>
      TotalCostVariants(
        variantCost: json["variant_cost"],
        variantQuantity: json["variant_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "variant_cost": variantCost,
        "variant_quantity": variantQuantity,
      };
}
