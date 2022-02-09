import 'dart:async';
import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobilepos/Modules/Purchasehistory/PurchasedHistory_controller.dart';

import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_api.dart';
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_model.dart';
import 'package:mobilepos/helpers/Discount_helper.dart';
import 'package:mobilepos/helpers/connectivity.dart';
import 'package:mobilepos/helpers/storage.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TransactionDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  final ItemScrollController itemTabScrollController = ItemScrollController();
  final ItemPositionsListener itemTabPositionsListener =
      ItemPositionsListener.create();
  TabController? tabController;

  RxList<TransactionDetails> itemList = <TransactionDetails>[].obs;
  RxList<TransactionDetails> itemListMasterList = <TransactionDetails>[].obs;
  RxBool isGettingList = true.obs;

  RxList<FinalTransactionModel> finalItemsList = <FinalTransactionModel>[].obs;
  RxList<FinalTransactionModel> finalItemsList_MasterList =
      <FinalTransactionModel>[].obs;

  RxList<InstallmentDetails> installmentDetailsList =
      <InstallmentDetails>[].obs;
  final DiscountHelper cal = DiscountHelper();

  BluetoothPrint bluetooth = BluetoothPrint.instance;

  List<String> items = [
    'One',
    'Two',
  ];

  RxString ordernumber = ''.obs;
  RxDouble additional_checkout_discount = 0.0.obs;
  RxString additional_checkout_discount_type = ''.obs;
  RxString order_payment_type = ''.obs;

  RxString installment_percent_value = '0'.obs;
  RxInt installment_Days_to_pay = 0.obs;
  RxBool isLoadingGettingInstallmentDetails = true.obs;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    await getdata();
  }

  RxList bestSeller = [
    {
      "image":
          "https://media.istockphoto.com/photos/flashlight-picture-id1050260814?k=6&m=1050260814&s=170667a&w=0&h=A1Cno2fui8Od8hUbnpIPtHsw5dY55cyfdDm1x5abwSY=",
      "name": "Flaslight LED MUG"
    },
    {
      "image":
          "https://tse4.mm.bing.net/th?id=OIP.X8IiXpOPBYT-zjuyVFisgAHaHI&pid=Api&P=0&w=161&h=155",
      "name": "Eternal Derringer Flashlight"
    },
    {
      "image":
          "https://tse2.mm.bing.net/th?id=OIP.Wxk9I3ZCU8zmQrMoYhRKRQHaE3&pid=Api&P=0&w=250&h=164",
      "name": "Blocklight LED 9V Flashlight"
    },
  ].obs;

  RxList bestDeals = [
    {
      "name": "Yamaha MZ360cc OHV",
      "image":
          "https://tse2.mm.bing.net/th?id=OIP.WsuGeVyUMe_hGWlms0h9RgHaHz&pid=Api&P=0&w=151&h=159"
    },
    {
      "name": "YZF R1 Engine",
      "image":
          "https://libraryimg.yamaha-motor.co.jp/images/L/e1b7ef0c616c251cd499ca72cd7f97df"
    },
    {
      "name": "Brilliance Gasoline",
      "image":
          "https://tse2.mm.bing.net/th?id=OIP.CyccnIIA_xZjOvjbUfGAHQHaE8&pid=Api&P=0&w=246&h=164"
    },
  ].obs;

  RxList apparels = [
    {
      "name": "American Wire THHN Stranded",
      "price": "P 2,000.00",
      "image":
          "https://tse3.mm.bing.net/th?id=OIP.WqFwXeoabAjj67sF9_chSgAAAA&pid=Api&P=0&w=119&h=158"
    },
    {
      "name": "TXL XLPE Insulation",
      "price": "P 3,900.00",
      "image":
          "https://tse4.mm.bing.net/th?id=OIP.QigZyMfZ5vwKme8x3gM5YQHaGk&pid=Api&P=0&w=188&h=166"
    }
  ].obs;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  getdata() async {
    ordernumber.value = await Get.arguments['ordernumber'];
    additional_checkout_discount.value =
        await Get.arguments['additional_checkout_discount'];
    additional_checkout_discount_type.value =
        await Get.arguments['additional_checkout_discount_type'];
    order_payment_type.value = await Get.arguments['order_payment_type'];
    print("order number : $ordernumber");
    print("dicsount value: ${additional_checkout_discount.value}");
    print("discount type ${additional_checkout_discount_type}");
    print("order type: ${order_payment_type}");
    if (Get.find<ConnectivityService>().hasConnection.value == true) {
      getItemList();
    } else {
      get_items_list_offline_mode();
    }
    if (order_payment_type.value == 'Installment') {
      getInstallmentDetails();
    }
  }

  getItemList() async {
    var result = await TransactionDetailsApi.get_History_items(
        ordernumber: ordernumber.value);
    itemList.assignAll(result);
    itemListMasterList.assignAll(result);

    final stores = itemList.map((e) => e.itemId).toSet();
    itemList.retainWhere((x) => stores.remove(x.itemId));

    var tempItemListMainItemList = [];
    for (var i = 0; i < itemList.length; i++) {
      Map map = {
        "ordernumber": itemList[i].ordernumber,
        "item_id": itemList[i].itemId,
        "item_name": itemList[i].itemName,
        "item_barcode": itemList[i].itemBarcode,
        "item_price": itemList[i].itemPrice,
        "item_has_variants": itemList[i].itemHasVariants,
        "item_category_name": itemList[i].itemCategoryName,
        "item_Discount": itemList[i].itemDiscount,
        "item_Discount_type": itemList[i].itemDiscountType,
        "itemQuantity": itemList[i].itemQuantity,
        "item_list_of_variants": []
      };
      tempItemListMainItemList.add(map);
    }

    for (var i = 0; i < tempItemListMainItemList.length; i++) {
      for (var z = 0; z < itemListMasterList.length; z++) {
        if (tempItemListMainItemList[i]['item_id'] ==
            itemListMasterList[z].itemId) {
          Map variantMap = {
            "ordernumber": itemList[i].ordernumber,
            "variant_id": itemListMasterList[z].variantId,
            "variant_name": itemListMasterList[z].variantName,
            "variant_price": itemListMasterList[z].variantPrice,
            "variant_mainitem_id": itemListMasterList[z].variantMainitemId,
            "variant_discount": itemListMasterList[z].variantDiscount,
            "variant_discount_type": itemListMasterList[z].variantDiscountType,
            "variant_quantity": itemListMasterList[z].variantQuantity,
          };
          tempItemListMainItemList[i]['item_list_of_variants'].add(variantMap);
        }
      }
    }
    // print(tempItemListMainItemList);
    finalItemsList.assignAll(
        finalTransactionModelFromJson(jsonEncode(tempItemListMainItemList)));
    finalItemsList_MasterList.assignAll(
        finalTransactionModelFromJson(jsonEncode(tempItemListMainItemList)));
    isGettingList(false);
  }

  get_items_list_offline_mode() {
    if (Get.find<StorageService>().box.read('listofordereditems') == null) {
    } else {
      finalItemsList_MasterList.assignAll(finalTransactionModelFromJson(
          jsonEncode(
              Get.find<StorageService>().box.read('listofordereditems'))));
      for (var i = 0; i < finalItemsList_MasterList.length; i++) {
        if (ordernumber.value.trim() ==
            finalItemsList_MasterList[i].ordernumber.trim()) {
          finalItemsList.add(finalItemsList_MasterList[i]);
        } else {}
      }
      finalItemsList_MasterList.assignAll(finalItemsList);
    }
  }

  getInstallmentDetails() async {
    var result = await TransactionDetailsApi.get_installment_Details(
        ordernumber: ordernumber.value);
    installmentDetailsList.assignAll(result);
    installment_percent_value.value =
        installmentDetailsList[0].installmentPercentValue;
    installment_Days_to_pay.value = installmentDetailsList[0].daysOfInstallment;

    isLoadingGettingInstallmentDetails(false);
  }

  RxDouble total_installment_amount() {
    var total = (double.parse(installment_percent_value.value) *
        countotal_Amount_discounted().value);
    total = total * installment_Days_to_pay.value +
        countotal_Amount_discounted().value;
    return total.obs;
  }

  RxDouble installment_amount_per_Day() {
    var total = (double.parse(installment_percent_value.value) *
        countotal_Amount_discounted().value);
    return total.obs;
  }

  RxDouble count_total_for_no_variants({required int index}) {
    var total = 0.0;
    total = total +
        (finalItemsList[index].itemQuantity *
            double.parse(finalItemsList[index].itemPrice));
    return total.obs;
  }

  RxDouble count_total_for_has_variants(
      {required List<ItemListOfVariantHistory> variantList}) {
    var total = 0.0;
    for (var i = 0; i < variantList.length; i++) {
      total = total +
          (variantList[i].variantQuantity *
              double.parse(variantList[i].variantPrice));
    }

    return total.obs;
  }

  RxDouble not_discounted_amount() {
    var total = 0.0;
    for (var i = 0; i < finalItemsList.length; i++) {
      if (finalItemsList[i].itemHasVariants == 0) {
        total = total +
            (finalItemsList[i].itemQuantity *
                double.parse(finalItemsList[i].itemPrice));
      } else {
        for (var z = 0; z < finalItemsList[i].itemListOfVariants.length; z++) {
          total = total +
              (finalItemsList[i].itemListOfVariants[z].variantQuantity *
                  double.parse(
                      finalItemsList[i].itemListOfVariants[z].variantPrice));
        }
      }
    }

    return total.obs;
  }

  RxDouble total_discount() {
    var total =
        not_discounted_amount().value - countotal_Amount_discounted().value;
    return total.obs;
  }

  RxDouble countotal_Amount_discounted() {
    var total = 0.0;
    for (var i = 0; i < finalItemsList.length; i++) {
      if (finalItemsList[i].itemHasVariants == 0) {
        if (finalItemsList[i].itemDiscountType == "Amount") {
          total = total +
              ((double.parse(finalItemsList[i].itemPrice) -
                      double.parse(finalItemsList[i].itemDiscount)) *
                  finalItemsList[i].itemQuantity);
        } else {
          total = total +
              ((double.parse(finalItemsList[i].itemPrice) -
                      ((double.parse(finalItemsList[i].itemDiscount) / 100)) *
                          double.parse(finalItemsList[i].itemPrice)) *
                  finalItemsList[i].itemQuantity);
        }
      } else {
        for (var z = 0; z < finalItemsList[i].itemListOfVariants.length; z++) {
          if (finalItemsList[i].itemListOfVariants[z].variantDiscountType ==
              "Amount") {
            total = total +
                ((double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantPrice) -
                        double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantDiscount)) *
                    finalItemsList[i].itemListOfVariants[z].variantQuantity);
          } else {
            total = total +
                ((double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantPrice) -
                        ((double.parse(finalItemsList[i]
                                    .itemListOfVariants[z]
                                    .variantDiscount) /
                                100) *
                            double.parse(finalItemsList[i]
                                .itemListOfVariants[z]
                                .variantPrice))) *
                    finalItemsList[i].itemListOfVariants[z].variantQuantity);
          }
        }
      }
    }
    if (additional_checkout_discount_type.value == "Amount") {
      total = total - additional_checkout_discount.value;
    } else {
      total = total - ((additional_checkout_discount.value / 100) * total);
    }
    return total.obs;
  }

  RxDouble get_Discount_of_item_or_Variants(
      {required double price,
      required double discount,
      required String discounttype,
      required int quantity}) {
    var total = 0.0;
    if (discounttype == "Amount") {
      total = (discount) * quantity;
    } else {
      total = ((discount / 100) * price) * quantity;
    }
    return total.obs;
  }

  RxDouble count_total_amount_perItem_no_variants({
    required double itemprice,
    required int quantity,
    required double discount,
    required String discounttype,
  }) {
    var total = 0.0;
    if (discounttype == "Amount") {
      total = (itemprice - discount) * quantity;
    } else {
      total = (itemprice - (((discount / 100)) * itemprice)) * quantity;
    }
    return total.obs;
  }

  RxDouble variant_receipt_count_total_amount({
    required double itemprice,
    required int quantity,
    required double discount,
    required String discounttype,
  }) {
    var total = 0.0;
    if (discounttype == "Amount") {
      total = (itemprice - discount) * quantity;
    } else {
      total = (itemprice - (((discount / 100)) * itemprice)) * quantity;
    }
    return total.obs;
  }

  List<LineText> list = [];
  Map<String, dynamic> config = {};
  Future<void> printReceipt_cash_or_creditS(
      {required String paymentype}) async {
    // ByteData data = await rootBundle.load('assets/images/pos_icon_small.png');
    // List<int> imageBytes =
    //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // String base64Image = base64Encode(imageBytes);
    // list.add(LineText(
    //     type: LineText.TYPE_IMAGE,
    //     content: base64Image,
    //     align: LineText.ALIGN_CENTER,
    //     linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Mobile POS Prototype',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tech Store',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'TIN: 000-000-000-000',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '3F, Union Building',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Quezon City, Metro Manila',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));

    for (var i = 0; i < finalItemsList.length; i++) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: finalItemsList[i].itemName,
          weight: 1,
          height: 1,
          align: LineText.ALIGN_CENTER,
          linefeed: 1));

      if (finalItemsList[i].itemHasVariants == 0) {
        list.add(LineText(
            // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
            type: LineText.TYPE_TEXT,
            content:
                '${finalItemsList[i].itemQuantity.toString()} * ${finalItemsList[i].itemPrice.toString()} = ' +
                    (finalItemsList[i].itemQuantity *
                            double.parse(finalItemsList[i].itemPrice))
                        .toStringAsFixed(2),
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1));
        if (get_Discount_of_item_or_Variants(
                    price: double.parse(finalItemsList[i].itemPrice),
                    discount: double.parse(finalItemsList[i].itemDiscount),
                    discounttype: finalItemsList[i].itemDiscountType,
                    quantity: finalItemsList[i].itemQuantity)
                .value !=
            0.0) {
          list.add(LineText(
              // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
              type: LineText.TYPE_TEXT,
              content: 'Discount : ' +
                  get_Discount_of_item_or_Variants(
                          price: double.parse(finalItemsList[i].itemPrice),
                          discount:
                              double.parse(finalItemsList[i].itemDiscount),
                          discounttype: finalItemsList[i].itemDiscountType,
                          quantity: finalItemsList[i].itemQuantity)
                      .toStringAsFixed(2),
              weight: 0,
              align: LineText.ALIGN_LEFT,
              linefeed: 1));
        }
        // list.add(LineText(
        //     type: LineText.TYPE_TEXT,
        //     content: 'Subtotal : ' +
        //         count_total_amount_perItem_no_variants(
        //                 discounttype: finalItemsList[i].itemDiscountType,
        //                 discount: double.parse(finalItemsList[i].itemDiscount),
        //                 quantity: finalItemsList[i].itemQuantity,
        //                 itemprice: double.parse(finalItemsList[i].itemPrice))
        //             .toStringAsFixed(2),
        //     weight: 0,
        //     align: LineText.ALIGN_LEFT,
        //     linefeed: 1));
      } else {
        for (var z = 0; z < finalItemsList[i].itemListOfVariants.length; z++) {
          if (finalItemsList[i].itemListOfVariants[z].variantQuantity != 0) {
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${finalItemsList[i].itemListOfVariants[z].variantName}',
                weight: 1,
                height: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${finalItemsList[i].itemListOfVariants[z].variantQuantity.toString()} x ${finalItemsList[i].itemListOfVariants[z]..variantPrice} = ' +
                        (finalItemsList[i]
                                    .itemListOfVariants[z]
                                    .variantQuantity *
                                (double.parse(finalItemsList[i]
                                    .itemListOfVariants[z]
                                    .variantPrice)))
                            .toStringAsFixed(2)
                            .toString(),
                weight: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            if (get_Discount_of_item_or_Variants(
                        price: double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantPrice),
                        quantity: finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantQuantity,
                        discount: double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantDiscount),
                        discounttype: finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantDiscountType)
                    .value !=
                0.0) {
              list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Discount:' +
                      get_Discount_of_item_or_Variants(
                              price: double.parse(finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantPrice),
                              quantity: finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantQuantity,
                              discount: double.parse(finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantDiscount),
                              discounttype: finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantDiscountType)
                          .toStringAsFixed(2),
                  weight: 1,
                  height: 0,
                  align: LineText.ALIGN_LEFT,
                  linefeed: 1));
            }
            // list.add(LineText(
            //     type: LineText.TYPE_TEXT,
            //     content: 'Subtotal:' +
            //         variant_receipt_count_total_amount(
            //                 itemprice: double.parse(finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantPrice),
            //                 quantity: finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantQuantity,
            //                 discount: double.parse(finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantDiscount),
            //                 discounttype: finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantDiscountType)
            //             .toStringAsFixed(2),
            //     weight: 1,
            //     height: 0,
            //     align: LineText.ALIGN_LEFT,
            //     linefeed: 1));
          } else {}
        }
      }
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Subtotal: P' +
            not_discounted_amount().value.toStringAsFixed(2).toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    if (total_discount().value != 0) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: 'Discount: P' +
              total_discount().value.toStringAsFixed(2).toString(),
          align: LineText.ALIGN_LEFT,
          weight: 2,
          linefeed: 1));
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Total: P' +
            countotal_Amount_discounted().value.toStringAsFixed(2).toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Type of Payment:  $paymentype',
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Thank you for your purchase!',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    await bluetooth.printReceipt(config, list);

    config.clear();
    list.clear();
  }

  Future<void> printReceipt_installment() async {
    // ByteData data = await rootBundle.load('assets/images/pos_icon_small.png');
    // List<int> imageBytes =
    //     data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    // String base64Image = base64Encode(imageBytes);
    // list.add(LineText(
    //     type: LineText.TYPE_IMAGE,
    //     content: base64Image,
    //     align: LineText.ALIGN_CENTER,
    //     linefeed: 1));

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Mobile POS Prototype',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Tech Store',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'TIN: 000-000-000-000',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: '3F, Union Building',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Quezon City, Metro Manila',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(linefeed: 1));

    for (var i = 0; i < finalItemsList.length; i++) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: '${finalItemsList[i].itemName}',
          weight: 1,
          height: 1,
          align: LineText.ALIGN_CENTER,
          linefeed: 1));

      if (finalItemsList[i].itemHasVariants == 0) {
        list.add(LineText(
            // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
            type: LineText.TYPE_TEXT,
            content:
                '${finalItemsList[i].itemQuantity.toString()} * ${finalItemsList[i].itemPrice.toString()} = ' +
                    (finalItemsList[i].itemQuantity *
                            double.parse(finalItemsList[i].itemPrice))
                        .toStringAsFixed(2),
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1));
        if (get_Discount_of_item_or_Variants(
                    price: double.parse(finalItemsList[i].itemPrice),
                    discount: double.parse(finalItemsList[i].itemDiscount),
                    discounttype: finalItemsList[i].itemDiscountType,
                    quantity: finalItemsList[i].itemQuantity)
                .value !=
            0.0) {
          list.add(LineText(
              // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
              type: LineText.TYPE_TEXT,
              content: 'Discount : ' +
                  get_Discount_of_item_or_Variants(
                          price: double.parse(finalItemsList[i].itemPrice),
                          discount:
                              double.parse(finalItemsList[i].itemDiscount),
                          discounttype: finalItemsList[i].itemDiscountType,
                          quantity: finalItemsList[i].itemQuantity)
                      .toStringAsFixed(2),
              weight: 0,
              align: LineText.ALIGN_LEFT,
              linefeed: 1));
        }
        // list.add(LineText(
        //     type: LineText.TYPE_TEXT,
        //     content: 'Subtotal : ' +
        //         count_total_amount_perItem_no_variants(
        //                 discounttype: finalItemsList[i].itemDiscountType,
        //                 discount: double.parse(finalItemsList[i].itemDiscount),
        //                 quantity: finalItemsList[i].itemQuantity,
        //                 itemprice: double.parse(finalItemsList[i].itemPrice))
        //             .toStringAsFixed(2),
        //     weight: 0,
        //     align: LineText.ALIGN_LEFT,
        //     linefeed: 1));
      } else {
        for (var z = 0; z < finalItemsList[i].itemListOfVariants.length; z++) {
          if (finalItemsList[i].itemListOfVariants[z].variantQuantity != 0) {
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${finalItemsList[i].itemListOfVariants[z].variantName}',
                weight: 1,
                height: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${finalItemsList[i].itemListOfVariants[z].variantQuantity.toString()} x ${finalItemsList[i].itemListOfVariants[z].variantPrice} = ' +
                        (finalItemsList[i]
                                    .itemListOfVariants[z]
                                    .variantQuantity *
                                (double.parse(finalItemsList[i]
                                    .itemListOfVariants[z]
                                    .variantPrice)))
                            .toStringAsFixed(2)
                            .toString(),
                weight: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            if (get_Discount_of_item_or_Variants(
                        price: double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantPrice),
                        quantity: finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantQuantity,
                        discount: double.parse(finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantDiscount),
                        discounttype: finalItemsList[i]
                            .itemListOfVariants[z]
                            .variantDiscountType)
                    .value !=
                0.0) {
              list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Discount:' +
                      get_Discount_of_item_or_Variants(
                              price: double.parse(finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantPrice),
                              quantity: finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantQuantity,
                              discount: double.parse(finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantDiscount),
                              discounttype: finalItemsList[i]
                                  .itemListOfVariants[z]
                                  .variantDiscountType)
                          .toStringAsFixed(2),
                  weight: 1,
                  height: 0,
                  align: LineText.ALIGN_LEFT,
                  linefeed: 1));
            }
            // list.add(LineText(
            //     type: LineText.TYPE_TEXT,
            //     content: 'Subtotal:' +
            //         variant_receipt_count_total_amount(
            //                 itemprice: double.parse(finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantPrice),
            //                 quantity: finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantQuantity,
            //                 discount: double.parse(finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantDiscount),
            //                 discounttype: finalItemsList[i]
            //                     .itemListOfVariants[z]
            //                     .variantDiscountType)
            //             .toStringAsFixed(2),
            //     weight: 1,
            //     height: 0,
            //     align: LineText.ALIGN_LEFT,
            //     linefeed: 1));
          }
        }
      }
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Subtotal: P' +
            not_discounted_amount().value.toStringAsFixed(2).toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    if (total_discount().value != 0) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: 'Discount: P' +
              total_discount().value.toStringAsFixed(2).toString(),
          align: LineText.ALIGN_LEFT,
          weight: 2,
          linefeed: 1));
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Total: P' +
            countotal_Amount_discounted().value.toStringAsFixed(2).toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Days to pay: ${installment_Days_to_pay.value.toString()}',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content:
            'Amount per day: ${installment_amount_per_Day().value.toStringAsFixed(2)}',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content:
            'Total Amount: ${total_installment_amount().value.toStringAsFixed(2)}',
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Type of Payment: Installment',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Thank you for your purchase!',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    await bluetooth.printReceipt(config, list);
    config.clear();
    list.clear();
  }

  RxDouble amount_per_Day = 0.0.obs;
  RxDouble installment_total_amount = 0.0.obs;

  count_total_installment_amount({required int days}) {
    var installment_Value_in_amount = countotal_Amount_discounted().value *
        double.parse(installment_percent_value.value);
    var amount_total_to_be_Added = installment_Value_in_amount * days;
    var final_installment_amount =
        countotal_Amount_discounted().value + amount_total_to_be_Added;
    amount_per_Day.value = installment_Value_in_amount;
    installment_total_amount.value = final_installment_amount;
  }

  String paymentpermonthString = '';
  RxBool isRefunding = false.obs;

  refundnow({required BuildContext context}) async {
    isRefunding(true);
    RxList<FinalTransactionModel> itemsToRefund = <FinalTransactionModel>[].obs;
    RxList<ItemListOfVariantHistory> variants =
        <ItemListOfVariantHistory>[].obs;
    for (var i = 0; i < finalItemsList.length; i++) {
      if (finalItemsList[i].checkboxbool == true) {
        itemsToRefund.add(finalItemsList[i]);
      }
    }

    for (var i = 0; i < finalItemsList.length; i++) {
      if (finalItemsList[i].itemHasVariants == 1) {
        for (var z = 0; z < finalItemsList[i].itemListOfVariants.length; z++) {
          if (finalItemsList[i].itemListOfVariants[z].variantBoolean == true) {
            variants.add(finalItemsList[i].itemListOfVariants[z]);
          }
        }
      }
    }

    for (var i = 0; i < itemsToRefund.length; i++) {
      var result = await TransactionDetailsApi.getitemDetails(
          itemid: itemsToRefund[i].itemId.toString());
      RxList<ItemDetailsForRefund> specificItem = <ItemDetailsForRefund>[].obs;
      specificItem.assignAll(result);

      if (itemsToRefund[i].itemHasVariants == 0) {
        var updatedCount = itemsToRefund[i].itemQuantity +
            int.parse(specificItem[0].itemCount);

        await TransactionDetailsApi.update_and_Delete_item(
            itemid: itemsToRefund[i].itemId.toString(),
            ordernumber: itemsToRefund[i].ordernumber.toString(),
            updatedItemCount: updatedCount.toString());
      } else {}
    }

    for (var z = 0; z < variants.length; z++) {
      var variantresult = await TransactionDetailsApi.getVariantDetails(
          variantID: variants[z].variantId.toString());
      RxList<VariantDetailsForRefund> variantToRefund =
          <VariantDetailsForRefund>[].obs;
      variantToRefund.assignAll(variantresult);
      var updatedVariantCount = variants[z].variantQuantity +
          int.parse(variantToRefund[0].variantCount);
      print("original variant count" + variantToRefund[0].variantCount);
      print("updated variant count" + updatedVariantCount.toString());
      await TransactionDetailsApi.update_and_Delete_variant(
          itemid: variants[z].variantMainitemId.toString(),
          variantid: variants[z].variantId.toString(),
          ordernumber: variants[z].ordernumber.toString(),
          updatedVariantCount: updatedVariantCount.toString());
    }

    await getItemList();

    await TransactionDetailsApi
        .update_total_amount_of_ordernumber_total_discount(
            ordernumber: ordernumber.value,
            totalDiscount: await total_discount().value.toString(),
            totalAmount: await countotal_Amount_discounted().value.toString());

    await Get.find<PurchasedHistoryController>().get_Sales_History();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Refund Succesful'),
    ));
    Get.back();

    isRefunding(false);
  }
}
