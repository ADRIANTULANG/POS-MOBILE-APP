import 'dart:convert';

List<Orderhistorytransaction> orderhistorytransactionFromJson(String str) =>
    List<Orderhistorytransaction>.from(
        json.decode(str).map((x) => Orderhistorytransaction.fromJson(x)));

String orderhistorytransactionToJson(List<Orderhistorytransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orderhistorytransaction {
  Orderhistorytransaction({
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
    required this.orderTotalAmount,
    required this.orderDateCreated,
    required this.orderTotalDiscount,
  });

  int orderid;
  String ordernumber;
  String orderUserid;
  String orderPaymentType;
  String orderStoreId;
  DateTime datetime;
  String additionalCheckoutDiscount;
  String additionalCheckoutDiscountType;
  int installmentId;
  int daysOfInstallment;
  int installmentPercentValue;
  String orderTotalAmount;
  String orderDateCreated;
  String orderTotalDiscount;

  factory Orderhistorytransaction.fromJson(Map<String, dynamic> json) =>
      Orderhistorytransaction(
        orderid: json["orderid"],
        ordernumber: json["ordernumber"],
        orderUserid: json["order_userid"],
        orderPaymentType: json["order_payment_type"],
        orderStoreId: json["order_store_id"],
        datetime: DateTime.parse(json["datetime"]),
        additionalCheckoutDiscount: json["additional_checkout_discount"],
        additionalCheckoutDiscountType:
            json["additional_checkout_discount_type"],
        installmentId: json["installment_id"],
        daysOfInstallment: json["days_of_installment"],
        installmentPercentValue: json["installment_percent_value"],
        orderTotalAmount: json["order_total_amount"],
        orderDateCreated: json["order_date_created"],
        orderTotalDiscount: json["order_total_discount"],
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
        "installment_id": installmentId,
        "days_of_installment": daysOfInstallment,
        "installment_percent_value": installmentPercentValue,
        "order_total_amount": orderTotalAmount,
        "order_date_created": orderDateCreated,
        "order_total_discount": orderTotalDiscount,
      };
}

List<Orderlistofitems> orderlistofitemsFromJson(String str) =>
    List<Orderlistofitems>.from(
        json.decode(str).map((x) => Orderlistofitems.fromJson(x)));

String orderlistofitemsToJson(List<Orderlistofitems> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orderlistofitems {
  Orderlistofitems({
    required this.ordernumber,
    required this.itemId,
    required this.itemName,
    required this.itemBarcode,
    required this.itemPrice,
    required this.itemHasVariants,
    required this.itemCategoryName,
    required this.itemCategoryId,
    required this.itemCost,
    required this.itemImage,
    required this.itemDiscount,
    required this.itemDiscountType,
    required this.itemQuantity,
    required this.itemListOfVariants,
  });

  String ordernumber;
  int itemId;
  String itemName;
  String itemBarcode;
  String itemPrice;
  int itemHasVariants;
  String itemCategoryName;
  int itemCategoryId;
  String itemCost;
  String itemImage;
  String itemDiscount;
  String itemDiscountType;
  int itemQuantity;
  List<ItemListOfVariant> itemListOfVariants;

  factory Orderlistofitems.fromJson(Map<String, dynamic> json) =>
      Orderlistofitems(
        ordernumber: json["ordernumber"],
        itemId: json["item_id"],
        itemName: json["item_name"],
        itemBarcode: json["item_barcode"],
        itemPrice: json["item_price"],
        itemHasVariants: json["item_has_variants"],
        itemCategoryName: json["item_category_name"],
        itemCategoryId: json["item_category_id"],
        itemCost: json["item_Cost"],
        itemImage: json["item_image"],
        itemDiscount: json["item_Discount"],
        itemDiscountType: json["item_Discount_type"],
        itemQuantity: json["itemQuantity"],
        itemListOfVariants: List<ItemListOfVariant>.from(
            json["item_list_of_variants"]
                .map((x) => ItemListOfVariant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ordernumber": ordernumber,
        "item_id": itemId,
        "item_name": itemName,
        "item_barcode": itemBarcode,
        "item_price": itemPrice,
        "item_has_variants": itemHasVariants,
        "item_category_name": itemCategoryName,
        "item_category_id": itemCategoryId,
        "item_Cost": itemCost,
        "item_image": itemImage,
        "item_Discount": itemDiscount,
        "item_Discount_type": itemDiscountType,
        "itemQuantity": itemQuantity,
        "item_list_of_variants":
            List<dynamic>.from(itemListOfVariants.map((x) => x.toJson())),
      };
}

class ItemListOfVariant {
  ItemListOfVariant({
    required this.ordernumber,
    required this.variantId,
    required this.variantName,
    required this.variantPrice,
    required this.variantMainitemId,
    required this.variantCount,
    required this.variantDiscount,
    required this.variantDiscountType,
    required this.variantQuantity,
  });

  String ordernumber;
  int variantId;
  String variantName;
  String variantPrice;
  int variantMainitemId;
  String variantCount;
  String variantDiscount;
  String variantDiscountType;
  int variantQuantity;

  factory ItemListOfVariant.fromJson(Map<String, dynamic> json) =>
      ItemListOfVariant(
        ordernumber: json["ordernumber"],
        variantId: json["variant_id"],
        variantName: json["variant_name"],
        variantPrice: json["variant_price"],
        variantMainitemId: json["variant_mainitem_id"],
        variantCount: json["variant_count"],
        variantDiscount: json["variant_discount"],
        variantDiscountType: json["variant_discount_type"],
        variantQuantity: json["variant_quantity"],
      );

  Map<String, dynamic> toJson() => {
        "ordernumber": ordernumber,
        "variant_id": variantId,
        "variant_name": variantName,
        "variant_price": variantPrice,
        "variant_mainitem_id": variantMainitemId,
        "variant_count": variantCount,
        "variant_discount": variantDiscount,
        "variant_discount_type": variantDiscountType,
        "variant_quantity": variantQuantity,
      };
}
