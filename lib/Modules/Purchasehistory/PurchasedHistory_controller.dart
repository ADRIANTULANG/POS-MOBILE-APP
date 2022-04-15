import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Checkout/Checkout_api.dart';
import 'package:mobilepos/Modules/Homepage/homepage_controller.dart';

import 'package:mobilepos/Modules/Purchasehistory/PurchasedHistory_api.dart';
import 'package:mobilepos/Modules/Purchasehistory/PurchasedHistory_model.dart';
import 'package:mobilepos/Modules/SplashScreen/Splashscreen_model.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/connectivity.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';

class PurchasedHistoryController extends GetxController {
  // RxList<History> historyList = <History>[].obs;

  TextEditingController searchField = TextEditingController();
  RxBool isSelect = false.obs;

  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  RxList<HistoryModel> masterhistoryList = <HistoryModel>[].obs;
  RxList<DailySalesForPrint> dailySales = <DailySalesForPrint>[].obs;
  RxList<DailySalesForPrint> salestotalcost = <DailySalesForPrint>[].obs;
  RxList<ExpensesDaily> expensesDaily = <ExpensesDaily>[].obs;

  RxBool isLoadingHistory = true.obs;
  @override
  void onInit() async {
    if (Get.find<ConnectivityService>().hasConnection.value == true) {
      await get_Sales_History();
      await get_Sales_daily_to_print();
      await get_expenses_to_deduct();
      await count_total_daily_Discount();
      await get_sales_total_cost();
      print("total sales cost: " + count_total_Cost().value.toStringAsFixed(2));
      print(
          "total expenses: " + count_total_Expenses().value.toStringAsFixed(2));
      print("total sales: " + count_total_amount_sales().toStringAsFixed(2));
      print("total amount: " +
          (count_total_amount_sales().value - count_total_Expenses().value)
              .toStringAsFixed(2));
      print(
          "total discount: " + count_total_daily_Discount().toStringAsFixed(2));
    } else {
      get_sales_history_offline_mode();
    }
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  get_Sales_History() async {
    var result = await PurchasedHistoryApi.get_History_sales();
    historyList.assignAll(result.reversed);
    masterhistoryList.assignAll(result);
    isLoadingHistory(false);
  }

  get_sales_total_cost() async {
    var result = await PurchasedHistoryApi.get_sales_total_cost_for_print();
    salestotalcost.assignAll(result);
  }

  get_sales_history_offline_mode() {
    var res;
    if (Get.find<StorageService>().box.read('orderhistory') == null) {
      res = <HistoryModel>[].obs;
    } else {
      res = historyModelFromJson(
          jsonEncode(Get.find<StorageService>().box.read('orderhistory')));
    }
    historyList.assignAll(res.reversed);
    masterhistoryList.assignAll(res);
    isLoadingHistory(false);
  }

  get_Sales_daily_to_print() async {
    String date = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();
    var result = await PurchasedHistoryApi.get_sales_for_print(date: date);
    dailySales.assignAll(result);

    // final stores = dailySales.map((e) => e.itemId).toSet();
    // dailySales.retainWhere((x) => stores.remove(x.itemId));
  }

  get_expenses_to_deduct() async {
    String date = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();
    var result = await PurchasedHistoryApi.get_daily_expenses(date: date);
    expensesDaily.assignAll(result);
  }

  onSearch({required String listValueToSearch}) {
    if (listValueToSearch.isNotEmpty || listValueToSearch != "") {
      historyList.assignAll(masterhistoryList
          .where((u) => (u.ordernumber
              .toString()
              .toLowerCase()
              .contains(listValueToSearch.toLowerCase())))
          .toList());
    } else {
      historyList.assignAll(masterhistoryList);
    }
  }

  showDialogSuccess() {
    Sizer sizer = Sizer();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          height: sizer.height(height: 18, context: Get.context),
          width: sizer.width(width: 20, context: Get.context),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            // color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: sizer.height(height: 2, context: Get.context),
              ),
              Text(
                "Message",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizer.font(fontsize: 15, context: Get.context),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 3, context: Get.context),
              ),
              Text(
                "Refunded!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: sizer.font(fontsize: 11, context: Get.context),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: Get.context),
              ),
              Container(
                  // padding: EdgeInsets.only(
                  //     left: sizer.width(width: 2, context: context),
                  //     right: sizer.width(width: 2, context: context)),
                  child: Divider(
                color: Colors.black,
              )),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  // color: Colors.red,
                  alignment: Alignment.center,
                  width: sizer.width(width: 50, context: Get.context),
                  height: sizer.height(height: 5, context: Get.context),
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 15, context: Get.context),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  RxDouble count_total_amount_sales() {
    var total = 0.0;
    for (var i = 0; i < dailySales.length; i++) {
      total = total + double.parse(dailySales[i].orderTotalAmount);
    }
    return total.obs;
  }

  RxDouble count_total_daily_Discount() {
    var total = 0.0;
    for (var i = 0; i < dailySales.length; i++) {
      total = total + double.parse(dailySales[i].order_total_discount);
    }
    return total.obs;
  }

  RxDouble count_total_amount_sales_cash() {
    var total = 0.0;
    for (var i = 0; i < dailySales.length; i++) {
      if (dailySales[i].orderPaymentType == "Cash") {
        total = total + double.parse(dailySales[i].orderTotalAmount);
      }
    }
    return total.obs;
  }

  RxDouble count_total_amount_sales_credit() {
    var total = 0.0;
    for (var i = 0; i < dailySales.length; i++) {
      if (dailySales[i].orderPaymentType == "Credit") {
        total = total + double.parse(dailySales[i].orderTotalAmount);
      }
    }
    return total.obs;
  }

  RxDouble count_total_amount_sales_installment() {
    var total = 0.0;
    for (var i = 0; i < dailySales.length; i++) {
      if (dailySales[i].orderPaymentType == "Installment") {
        total = total + double.parse(dailySales[i].orderTotalAmount);
      }
    }
    return total.obs;
  }

  RxDouble count_total_Cost() {
    var total = 0.0;
    for (var i = 0; i < salestotalcost.length; i++) {
      total = total + double.parse(salestotalcost[i].orderTotalAmount);
    }
    return total.obs;
  }

  RxDouble count_total_Expenses() {
    var total = 0.0;
    for (var i = 0; i < expensesDaily.length; i++) {
      total = total + double.parse(expensesDaily[i].expensesAmount);
    }
    return total.obs;
  }

  List<LineText> list = [];
  Map<String, dynamic> config = {};

  Future<void> print_daily_sales() async {
    String date = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Mobile POS Prototype',
        weight: 3,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Daily Sales, Expenses, Discounts and Payments',
        weight: 3,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: date,
        weight: 3,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    for (var i = 0; i < expensesDaily.length; i++) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: "Expenses: P" +
              double.parse(expensesDaily[i].expensesAmount).toStringAsFixed(2),
          weight: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: "Note: " +
              expensesDaily[i].expensesNote.capitalizeFirst.toString(),
          weight: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));
      list.add(LineText(linefeed: 1));
    }

    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "TOTAL SALES COST: " +
            "P " +
            await count_total_Cost().value.toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "CASH PAYMENT TYPE: " +
            "P " +
            await count_total_amount_sales_cash().value.toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "CREDIT PAYMENT TYPE: " +
            "P " +
            await count_total_amount_sales_credit().value.toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "INSTALLMENT PAYMENT TYPE: " +
            "P " +
            await count_total_amount_sales_installment()
                .value
                .toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "DAILY EXPENSES: " +
            "P " +
            await count_total_Expenses().value.toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "TOTAL DAILY DISCOUNT: " +
            "P " +
            await count_total_daily_Discount().value.toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "TOTAL DAILY AMOUNT SALES: " +
            "P " +
            await count_total_amount_sales().toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: "TOTAL DAILY AMOUNT: " +
            "P " +
            (await count_total_amount_sales().value -
                    await count_total_Expenses().value)
                .toStringAsFixed(2),
        weight: 3,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    await Get.find<BluetoothServices>().bluetooth.printReceipt(config, list);
    config.clear();
    list.clear();
  }

  save_transactions_into_database({required BuildContext context}) async {
    // print(jsonEncode(Get.find<StorageService>().box.read('orderhistory')));
    // print(
    //     jsonEncode(Get.find<StorageService>().box.read('listofordereditems')));
    RxList<Orderhistorytransaction> orderhistorytransaction =
        <Orderhistorytransaction>[].obs;
    RxList<Orderlistofitems> orderlistofitems = <Orderlistofitems>[].obs;
    if (Get.find<StorageService>().box.read('orderhistory') != null) {
      orderhistorytransaction.assignAll(orderhistorytransactionFromJson(
          jsonEncode(Get.find<StorageService>().box.read('orderhistory'))));
    }
    if (Get.find<StorageService>().box.read('listofordereditems') != null) {
      orderlistofitems.assignAll(orderlistofitemsFromJson(jsonEncode(
          Get.find<StorageService>().box.read('listofordereditems'))));
    }

    for (var i = 0; i < orderhistorytransaction.length; i++) {
      String currentdate = DateTime.now().year.toString() +
          "-" +
          DateTime.now().month.toString() +
          "-" +
          DateTime.now().day.toString();
      var result = await CheckoutApi.create_order_purchase_order(
        currentdateFull: DateTime.now().toString(),
        totalAmount: orderhistorytransaction[i].orderTotalAmount,
        totalDiscount: orderhistorytransaction[i].orderTotalDiscount,
        currentdate: currentdate,
        paymenttype: orderhistorytransaction[i].orderPaymentType,
        additional_checkout_discount:
            orderhistorytransaction[i].additionalCheckoutDiscount,
        additional_checkout_discount_type:
            orderhistorytransaction[i].additionalCheckoutDiscountType,
      );

      for (var z = 0; z < orderlistofitems.length; z++) {
        if (orderlistofitems[z].ordernumber ==
            orderhistorytransaction[i].ordernumber) {
          update_item_count(
              itemid: orderlistofitems[z].itemId,
              quantity: orderlistofitems[z].itemQuantity);
          var lastinsertedID = await CheckoutApi.save_items(
              ordernumber: result,
              item_discount: orderlistofitems[z].itemDiscount.toString(),
              item_discount_type:
                  orderlistofitems[z].itemDiscountType.toString(),
              item_id: orderlistofitems[z].itemId.toString(),
              item_name: orderlistofitems[z].itemName.toString(),
              item_category_id: orderlistofitems[z].itemCategoryId.toString(),
              item_cost: orderlistofitems[z].itemCost.toString(),
              item_barcode: orderlistofitems[z].itemBarcode.toString(),
              item_price: orderlistofitems[z].itemPrice.toString(),
              item_store_id: Get.find<StorageService>().box.read('storeid'),
              item_has_variants: orderlistofitems[z].itemHasVariants.toString(),
              item_category_name:
                  orderlistofitems[z].itemCategoryName.toString(),
              item_image: orderlistofitems[z].itemImage.toString(),
              item_quantity: orderlistofitems[z].itemQuantity.toString(),
              item_date_created: currentdate);
          if (orderlistofitems[z].itemHasVariants == 1) {
            for (var j = 0;
                j < orderlistofitems[z].itemListOfVariants.length;
                j++) {
              if (orderlistofitems[z].itemListOfVariants[j].variantQuantity >
                  0) {
                update_variant_count(
                  itemid: orderlistofitems[z].itemId,
                  variantid:
                      orderlistofitems[z].itemListOfVariants[j].variantId,
                  variantQuantity:
                      orderlistofitems[z].itemListOfVariants[j].variantQuantity,
                );
                await CheckoutApi.save_variants(
                  lastinsertedID: lastinsertedID,
                  variant_date_created: currentdate,
                  ordernumber: result,
                  variant_discount:
                      orderlistofitems[z].itemListOfVariants[j].variantDiscount,
                  variant_discount_type: orderlistofitems[z]
                      .itemListOfVariants[j]
                      .variantDiscountType,
                  variant_id: orderlistofitems[z]
                      .itemListOfVariants[j]
                      .variantId
                      .toString(),
                  variant_name:
                      orderlistofitems[z].itemListOfVariants[j].variantName,
                  variant_count:
                      orderlistofitems[z].itemListOfVariants[j].variantCount,
                  variant_price:
                      orderlistofitems[z].itemListOfVariants[j].variantPrice,
                  variant_mainitem_id: orderlistofitems[z]
                      .itemListOfVariants[j]
                      .variantMainitemId
                      .toString(),
                  variant_store_id:
                      Get.find<StorageService>().box.read('storeid').toString(),
                  variant_quantity: orderlistofitems[z]
                      .itemListOfVariants[j]
                      .variantQuantity
                      .toString(),
                );
              }
            }
          }
        }
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Succesfuly Sync'),
    ));
    Get.find<StorageService>().box.remove('orderhistory');
    Get.find<StorageService>().box.remove('listofordereditems');
    await get_Sales_History();
  }

  update_item_count({required int itemid, required int quantity}) async {
    for (var i = 0; i < Get.find<HomepageController>().itemsList.length; i++) {
      if (Get.find<HomepageController>().itemsList[i].itemId == itemid) {
        var updatedItemCount =
            int.parse(Get.find<HomepageController>().itemsList[i].itemCount) -
                quantity;
        print(updatedItemCount.toString());
        await CheckoutApi.update_item_count(
            itemid: itemid.toString(),
            updatedCount: updatedItemCount.toString());
      }
    }
  }

  update_variant_count(
      {required int itemid,
      required int variantid,
      required int variantQuantity}) async {
    for (var i = 0; i < Get.find<HomepageController>().itemsList.length; i++) {
      if (Get.find<HomepageController>().itemsList[i].itemId == itemid) {
        for (var z = 0;
            z <
                Get.find<HomepageController>()
                    .itemsList[i]
                    .itemListOfVariants
                    .length;
            z++) {
          if (Get.find<HomepageController>()
                  .itemsList[i]
                  .itemListOfVariants[z]
                  .variantId ==
              variantid) {
            var updatedVariantCount = int.parse(Get.find<HomepageController>()
                    .itemsList[i]
                    .itemListOfVariants[z]
                    .variantCount) -
                variantQuantity;
            await CheckoutApi.update_variant_count(
                variantID: variantid.toString(),
                updatedVariantCount: updatedVariantCount.toString());
            print(updatedVariantCount.toString());
          }
        }
      }
    }
  }
}
