import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:get_storage/get_storage.dart';
import 'package:mobilepos/Model/CartModel.dart';
import 'package:mobilepos/Model/storedDataModel.dart';
import 'package:mobilepos/Modules/Checkout/Checkout_api.dart';
import 'package:mobilepos/Modules/Checkout/Checkout_model.dart';
import 'package:mobilepos/Modules/Homepage/homepage_controller.dart';
import 'package:mobilepos/helpers/CartServices.dart';
import 'package:mobilepos/helpers/DiscountServices.dart';
import 'package:mobilepos/helpers/Discount_helper.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/connectivity.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:mobilepos/helpers/storage.dart';

class CheckoutController extends GetxController {
  // RxList<StoreDataModel> cartList = <StoreDataModel>[].obs;
  final box = GetStorage();
  final DiscountHelper cal = DiscountHelper();

  RxDouble change = 0.0.obs;

  // RxString dropdownvalue = '3 months'.obs;

  TextEditingController daysTextEditing = TextEditingController();

  // BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  TextEditingController amountReceived = TextEditingController();
  TextEditingController customerName = TextEditingController();

  TextEditingController enterquantity = TextEditingController();

  // BluetoothPrint bluetooth = BluetoothPrint.instance;

  RxDouble installment_value = 0.0.obs;

  RxDouble amount_per_Day = 0.0.obs;
  RxDouble installment_total_amount = 0.0.obs;

  @override
  void onInit() async {
    if (Get.find<ConnectivityService>().hasConnection.value == true) {
      await Get.find<DiscountServices>().ge_all_Discount();
      await get_installment_value();
    } else {
      await Get.find<DiscountServices>().get_all_discounts_offline_mode();
    }
    super.onInit();
  }

  Map<String, dynamic> config = {};

  RxDouble discountForCheckOut = 0.0.obs;
  RxString discountTypeForCheckout = "".obs;

  List<LineText> list = [];

  RxList<Installment> installmentlists = <Installment>[].obs;
  RxBool isLoadingTransaction = false.obs;

  create_order(
      {required String paymenttype, required BuildContext context}) async {
    isLoadingTransaction(true);
    String currentdate = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();
    var result = await CheckoutApi.create_order_purchase_order(
        currentdateFull: DateTime.now().toString(),
        totalAmount: paymenttype == 'Installment'
            ? installment_total_amount.value.toString()
            : countotal_Amount(cart: Get.find<CartServices>().cart)
                .value
                .toString(),
        totalDiscount: total_Discount().value.toString(),
        currentdate: currentdate,
        paymenttype: paymenttype,
        additional_checkout_discount: discountForCheckOut.value.toString(),
        additional_checkout_discount_type: discountTypeForCheckout.value);

    save_items_and_variants(
        ordernumber: result, context: context, currentdate: currentdate);
    if (paymenttype == "Installment") {
      var installment_result = await CheckoutApi.add_installment(
          ordernumber: result,
          days_of_installment: daysTextEditing.text,
          installment_percent_value: installment_value.value.toString());
      print(installment_result);
    }
  }

  save_items_and_variants({
    required String ordernumber,
    required BuildContext context,
    required String currentdate,
  }) async {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (Get.find<CartServices>().cart[i].itemHasVariants == 0) {
        update_item_count(
            itemid: Get.find<CartServices>().cart[i].itemId,
            quantity: Get.find<CartServices>().cart[i].item_Quantity.value);
      }
      var lastinsertedID = await CheckoutApi.save_items(
          ordernumber: ordernumber,
          item_discount:
              Get.find<CartServices>().cart[i].item_Discount.toString(),
          item_discount_type:
              Get.find<CartServices>().cart[i].item_discount_type.toString(),
          item_id: Get.find<CartServices>().cart[i].itemId.toString(),
          item_name: Get.find<CartServices>().cart[i].itemName.toString(),
          item_category_id:
              Get.find<CartServices>().cart[i].itemCategoryId.toString(),
          item_cost: Get.find<CartServices>().cart[i].itemCost.toString(),
          item_barcode: Get.find<CartServices>().cart[i].itemBarcode.toString(),
          item_price: Get.find<CartServices>().cart[i].itemPrice.toString(),
          item_store_id:
              Get.find<CartServices>().cart[i].itemStoreId.toString(),
          item_has_variants:
              Get.find<CartServices>().cart[i].itemHasVariants.toString(),
          item_category_name:
              Get.find<CartServices>().cart[i].itemCategoryName.toString(),
          item_image: Get.find<CartServices>().cart[i].itemImage.toString(),
          item_quantity:
              Get.find<CartServices>().cart[i].item_Quantity.value.toString(),
          item_date_created: currentdate);
      if (Get.find<CartServices>().cart[i].itemHasVariants == 1) {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_Quantity
                  .value >
              0) {
            update_variant_count(
                itemid: Get.find<CartServices>().cart[i].itemId,
                variantid: Get.find<CartServices>()
                    .cart[i]
                    .itemVariantList![z]
                    .variantId,
                variantQuantity: Get.find<CartServices>()
                    .cart[i]
                    .itemVariantList![z]
                    .variant_Quantity
                    .value);
            await CheckoutApi.save_variants(
              lastinsertedID: lastinsertedID,
              variant_date_created: currentdate,
              ordernumber: ordernumber,
              variant_discount: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_discount
                  .toString(),
              variant_discount_type: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_discount_type
                  .toString(),
              variant_id: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantId
                  .toString(),
              variant_name: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantName
                  .toString(),
              variant_count: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantCount
                  .toString(),
              variant_price: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantPrice
                  .toString(),
              variant_mainitem_id: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantMainitemId
                  .toString(),
              variant_store_id:
                  Get.find<StorageService>().box.read('storeid').toString(),
              variant_quantity: Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_Quantity
                  .value
                  .toString(),
            );
          }
        }
      }
    }
    isLoadingTransaction(false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Transaction Success Order no. $ordernumber'),
    ));
    await Get.find<HomepageController>().get_items();
    Get.back();
  }

  offline_transactions_save_to_local(
      {required String paymenttype, required BuildContext context}) async {
    String currentdate = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();
    var ordernumber = 0;
    if (Get.find<StorageService>().box.read('orderid') == null) {
      ordernumber = 0;
    } else {
      ordernumber = Get.find<StorageService>().box.read('orderid');
    }

    var tempItemListMainItemList = [];
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      List variantsList = [];
      if (Get.find<CartServices>().cart[i].itemHasVariants == 1) {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_Quantity
                  .value !=
              0) {
            Map variantList = {
              "ordernumber": "TRNSCTN" + ordernumber.toString(),
              "variant_id": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantId,
              "variant_name": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantName,
              "variant_price": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantPrice,
              "variant_mainitem_id": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantMainitemId,
              "variant_count": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variantCount,
              "variant_discount": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_discount,
              "variant_discount_type": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_discount_type,
              "variant_quantity": Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_Quantity
                  .value,
            };
            variantsList.add(variantList);
          }
        }
      }
      Map map = {
        "ordernumber": "TRNSCTN" + ordernumber.toString(),
        "item_id": Get.find<CartServices>().cart[i].itemId,
        "item_name": Get.find<CartServices>().cart[i].itemName,
        "item_barcode": Get.find<CartServices>().cart[i].itemBarcode,
        "item_price": Get.find<CartServices>().cart[i].itemPrice,
        "item_has_variants": Get.find<CartServices>().cart[i].itemHasVariants,
        "item_category_name": Get.find<CartServices>().cart[i].itemCategoryName,
        "item_category_id": Get.find<CartServices>().cart[i].itemCategoryId,
        "item_Cost": Get.find<CartServices>().cart[i].itemCost,
        "item_image": Get.find<CartServices>().cart[i].itemImage,
        "item_Discount": Get.find<CartServices>().cart[i].item_Discount,
        "item_Discount_type":
            Get.find<CartServices>().cart[i].item_discount_type,
        "itemQuantity": Get.find<CartServices>().cart[i].item_Quantity.value,
        "item_list_of_variants": variantsList
      };
      tempItemListMainItemList.add(map);
    }

    await Get.find<StorageService>()
        .saveOfflineItems(listofordereditems: tempItemListMainItemList);
    List transactionorderlist = [];
    Map ordernumbermap = {
      "orderid": ordernumber,
      "ordernumber": "TRNSCTN" + ordernumber.toString(),
      "order_userid": Get.find<StorageService>().box.read('userid'),
      "order_payment_type": paymenttype,
      "order_store_id": Get.find<StorageService>().box.read('storeid'),
      "datetime": DateTime.now().toString(),
      "additional_checkout_discount": discountForCheckOut.value.toString(),
      "additional_checkout_discount_type": discountTypeForCheckout.value,
      "installment_id": 0,
      "days_of_installment": 0,
      "installment_percent_value": 0,
      "order_total_amount":
          countotal_Amount(cart: Get.find<CartServices>().cart)
              .value
              .toString(),
      "order_date_created": currentdate,
      "order_total_discount": total_Discount().value.toString(),
    };
    transactionorderlist.add(ordernumbermap);
    ordernumber++;
    await Get.find<StorageService>().setOrderID(id: ordernumber);
    await Get.find<StorageService>()
        .setOrderHistory(orderhistory: transactionorderlist);
    isLoadingTransaction(false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Offline transaction succesful'),
    ));

    Get.find<HomepageController>().get_items_offline_mode();
    Get.back();
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

  get_installment_value() async {
    var result = await CheckoutApi.get_installment();
    installmentlists.assignAll(result);
    installment_value.value =
        double.parse(installmentlists[0].installmentPercentValue) / 100;
  }

  add_quantity_no_variants({required int mainitemId}) {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (mainitemId == Get.find<CartServices>().cart[i].itemId) {
        Get.find<CartServices>().cart[i].item_Quantity++;
      }
    }
    Get.find<HomepageController>()
        .add_quantity_no_variants(mainItemID: mainitemId);
  }

  type_quantity_no_Variants(
      {required int mainItemID, required String quantity}) {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (mainItemID == Get.find<CartServices>().cart[i].itemId) {
        Get.find<CartServices>().cart[i].item_Quantity.value =
            int.parse(quantity);
      }
    }
    Get.find<HomepageController>()
        .type_quantity_no_Variants(mainItemID: mainItemID, quantity: quantity);
  }

  remove_quantity_no_variants({required int mainitemId}) {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (mainitemId == Get.find<CartServices>().cart[i].itemId) {
        Get.find<CartServices>().cart[i].item_Quantity--;
      }
    }
    for (var i = 0; i < Get.find<HomepageController>().itemsList.length; i++) {
      if (Get.find<HomepageController>().itemsList[i].itemId == mainitemId) {
        print("not masterList");
        Get.find<HomepageController>().itemsList[i].itemQuantity--;
      }
    }
  }

  add_quantity_has_variants({required int mainitemid, required int variantid}) {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (mainitemid == Get.find<CartServices>().cart[i].itemId) {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>().cart[i].itemVariantList![z].variantId ==
              variantid) {
            Get.find<CartServices>().cart[i].item_Quantity++;
            Get.find<CartServices>()
                .cart[i]
                .itemVariantList![z]
                .variant_Quantity
                .value++;
          }
        }
      }
    }
    Get.find<HomepageController>()
        .add_quantity_variant(variantId: variantid, mainItemID: mainitemid);
  }

  type_quantity_has_variant(
      {required int mainitemid,
      required int variantid,
      required int quantity}) {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (mainitemid == Get.find<CartServices>().cart[i].itemId) {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>().cart[i].itemVariantList![z].variantId ==
              variantid) {
            Get.find<CartServices>().cart[i].item_Quantity =
                Get.find<CartServices>().cart[i].item_Quantity -
                    Get.find<CartServices>()
                        .cart[i]
                        .itemVariantList![z]
                        .variant_Quantity
                        .value;
            Get.find<CartServices>()
                .cart[i]
                .itemVariantList![z]
                .variant_Quantity
                .value = quantity;
            Get.find<CartServices>().cart[i].item_Quantity =
                Get.find<CartServices>().cart[i].item_Quantity +
                    Get.find<CartServices>()
                        .cart[i]
                        .itemVariantList![z]
                        .variant_Quantity
                        .value;
          }
        }
      }
    }
    Get.find<HomepageController>().type_quantity_has_variants(
        variantId: variantid, mainItemID: mainitemid, quantity: quantity);
  }

  remove_quantity_has_variants(
      {required int mainitemid, required int variantid}) {
    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      if (mainitemid == Get.find<CartServices>().cart[i].itemId) {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>().cart[i].itemVariantList![z].variantId ==
              variantid) {
            Get.find<CartServices>().cart[i].item_Quantity--;
            Get.find<CartServices>()
                .cart[i]
                .itemVariantList![z]
                .variant_Quantity
                .value--;
          }
        }
      }
    }
    Get.find<HomepageController>()
        .remove_quantity_variant(variantId: variantid, mainItemID: mainitemid);
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

  RxDouble count_total_amount_perItem_no_variants_with_no_Discount({
    required double itemprice,
    required int quantity,
    required double discount,
    required String discounttype,
  }) {
    var total = 0.0;
    total = itemprice * quantity;
    return total.obs;
  }

  RxDouble count_total_amount_perItem_has_variants(
      {required List<ItemVariantList> listofvariants}) {
    double total = 0.0;
    for (var i = 0; i < listofvariants.length; i++) {
      if (listofvariants[i].variant_discount_type == "Amount") {
        total = total +
            ((double.parse(listofvariants[i].variantPrice) -
                    double.parse(listofvariants[i].variant_discount)) *
                listofvariants[i].variant_Quantity.value);
      } else {
        total = total +
            ((double.parse(listofvariants[i].variantPrice) -
                    ((double.parse(listofvariants[i].variant_discount) / 100)) *
                        double.parse(listofvariants[i].variantPrice)) *
                listofvariants[i].variant_Quantity.value);
      }
    }
    return total.obs;
  }

  RxDouble count_total_amount_perItem_has_variants_With_no_Discount(
      {required List<ItemVariantList> listofvariants}) {
    double total = 0.0;
    for (var i = 0; i < listofvariants.length; i++) {
      total = total +
          (double.parse(listofvariants[i].variantPrice) *
              listofvariants[i].variant_Quantity.value);
    }
    return total.obs;
  }

  RxDouble countotal_Amount({required List<CartList> cart}) {
    var total = 0.0;
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].itemHasVariants == 0) {
        if (cart[i].item_discount_type == "Amount") {
          total = total +
              ((double.parse(cart[i].itemPrice) -
                      double.parse(cart[i].item_Discount)) *
                  cart[i].item_Quantity.value);
        } else {
          total = total +
              ((double.parse(cart[i].itemPrice) -
                      ((double.parse(cart[i].item_Discount) / 100)) *
                          double.parse(cart[i].itemPrice)) *
                  cart[i].item_Quantity.value);
        }
      } else {
        for (var z = 0; z < cart[i].itemVariantList!.length; z++) {
          if (cart[i].itemVariantList![z].variant_discount_type == "Amount") {
            total = total +
                ((double.parse(cart[i].itemVariantList![z].variantPrice) -
                        double.parse(
                            cart[i].itemVariantList![z].variant_discount)) *
                    cart[i].itemVariantList![z].variant_Quantity.value);
          } else {
            total = total +
                ((double.parse(cart[i].itemVariantList![z].variantPrice) -
                        ((double.parse(cart[i]
                                    .itemVariantList![z]
                                    .variant_discount) /
                                100) *
                            double.parse(
                                cart[i].itemVariantList![z].variantPrice))) *
                    cart[i].itemVariantList![z].variant_Quantity.value);
          }
        }
      }
    }
    if (discountTypeForCheckout.value == "Amount") {
      total = total - discountForCheckOut.value;
    } else {
      total = total - ((discountForCheckOut.value / 100) * total);
    }
    return total.obs;
  }

  RxDouble countotal_Amount_with_no_Discount({required List<CartList> cart}) {
    var total = 0.0;
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].itemHasVariants == 0) {
        total = total +
            (double.parse(cart[i].itemPrice) * cart[i].item_Quantity.value);
      } else {
        for (var z = 0; z < cart[i].itemVariantList!.length; z++) {
          total = total +
              (double.parse(cart[i].itemVariantList![z].variantPrice) *
                  cart[i].itemVariantList![z].variant_Quantity.value);
        }
      }
    }
    // if (discountTypeForCheckout.value == "Amount") {
    //   total = total - discountForCheckOut.value;
    // } else {
    //   total = total - ((discountForCheckOut.value / 100) * total);
    // }
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

  calculate_change({required double amount}) {
    if (amount > countotal_Amount(cart: Get.find<CartServices>().cart).value) {
      change.value =
          amount - countotal_Amount(cart: Get.find<CartServices>().cart).value;
    } else {
      change(double.parse(0.0.toStringAsFixed(2)));
    }
  }

  count_total_installment_amount({required int days}) {
    var installment_Value_in_amount =
        countotal_Amount(cart: Get.find<CartServices>().cart).value *
            installment_value.value;
    var amount_total_to_be_Added = installment_Value_in_amount * days;
    var final_installment_amount =
        countotal_Amount(cart: Get.find<CartServices>().cart).value +
            amount_total_to_be_Added;
    amount_per_Day.value = installment_Value_in_amount;
    installment_total_amount.value = final_installment_amount;
  }

  Future<void> printReceipt_cash_or_credit({required String paymentype}) async {
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
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Customer Information',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Customer Name: ' + customerName.text,
        weight: 0,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: '${Get.find<CartServices>().cart[i].itemName}',
          weight: 1,
          // height: 1,
          align: LineText.ALIGN_LEFT,
          linefeed: 1));

      if (Get.find<CartServices>().cart[i].itemHasVariants == 0) {
        list.add(LineText(
            // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
            type: LineText.TYPE_TEXT,
            content:
                '${Get.find<CartServices>().cart[i].item_Quantity.value.toString()} x ${Get.find<CartServices>().cart[i].itemPrice.toString()} = ' +
                    (Get.find<CartServices>().cart[i].item_Quantity.value *
                            double.parse(
                                Get.find<CartServices>().cart[i].itemPrice))
                        .toStringAsFixed(2),
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1));
        if (get_Discount_of_item_or_Variants(
                    price: double.parse(
                        Get.find<CartServices>().cart[i].itemPrice),
                    discount: double.parse(
                        Get.find<CartServices>().cart[i].item_Discount),
                    discounttype:
                        Get.find<CartServices>().cart[i].item_discount_type,
                    quantity:
                        Get.find<CartServices>().cart[i].item_Quantity.value)
                .value !=
            0.0) {
          list.add(LineText(
              // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
              type: LineText.TYPE_TEXT,
              content: 'Discount : ' +
                  get_Discount_of_item_or_Variants(
                          price: double.parse(
                              Get.find<CartServices>().cart[i].itemPrice),
                          discount: double.parse(
                              Get.find<CartServices>().cart[i].item_Discount),
                          discounttype: Get.find<CartServices>()
                              .cart[i]
                              .item_discount_type,
                          quantity: Get.find<CartServices>()
                              .cart[i]
                              .item_Quantity
                              .value)
                      .toStringAsFixed(2),
              weight: 0,
              align: LineText.ALIGN_LEFT,
              linefeed: 1));
        }
        // list.add(LineText(
        //     type: LineText.TYPE_TEXT,
        //     content: 'Subtotal : ' +
        //         count_total_amount_perItem_no_variants(
        //                 discounttype:
        //                     Get.find<CartServices>().cart[i].item_discount_type,
        //                 discount: double.parse(
        //                     Get.find<CartServices>().cart[i].item_Discount),
        //                 quantity: Get.find<CartServices>()
        //                     .cart[i]
        //                     .item_Quantity
        //                     .value,
        //                 itemprice: double.parse(
        //                     Get.find<CartServices>().cart[i].itemPrice))
        //             .toStringAsFixed(2),
        //     weight: 0,
        //     align: LineText.ALIGN_LEFT,
        //     linefeed: 1));
      } else {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_Quantity
                  .value !=
              0) {
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${Get.find<CartServices>().cart[i].itemVariantList![z].variantName}',
                weight: 1,
                height: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${Get.find<CartServices>().cart[i].itemVariantList![z].variant_Quantity.value} x ${Get.find<CartServices>().cart[i].itemVariantList![z].variantPrice} = ' +
                        (Get.find<CartServices>()
                                    .cart[i]
                                    .itemVariantList![z]
                                    .variant_Quantity
                                    .value *
                                (double.parse(Get.find<CartServices>()
                                    .cart[i]
                                    .itemVariantList![z]
                                    .variantPrice)))
                            .toStringAsFixed(2)
                            .toString(),
                weight: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            if (get_Discount_of_item_or_Variants(
                        price: double.parse(Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variantPrice),
                        quantity: Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variant_Quantity
                            .value,
                        discount: double.parse(Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variant_discount),
                        discounttype: Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variant_discount_type)
                    .value !=
                0.0) {
              list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Discount:' +
                      get_Discount_of_item_or_Variants(
                              price: double.parse(Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variantPrice),
                              quantity: Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variant_Quantity
                                  .value,
                              discount: double.parse(Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variant_discount),
                              discounttype: Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variant_discount_type)
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
            //                 itemprice: double.parse(Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variantPrice),
            //                 quantity: Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variant_Quantity
            //                     .value,
            //                 discount: double.parse(Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variant_discount),
            //                 discounttype: Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variant_discount_type)
            //             .toStringAsFixed(2),
            //     weight: 1,
            //     height: 0,
            //     align: LineText.ALIGN_LEFT,
            //     linefeed: 1));
          } else {}
        }
      }
    }

    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Subtotal: ' +
            countotal_Amount_with_no_Discount(
                    cart: Get.find<CartServices>().cart)
                .value
                .toStringAsFixed(2)
                .toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    if (total_Discount().value != 0) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: 'Discount: ' +
              total_Discount().value.toStringAsFixed(2).toString(),
          align: LineText.ALIGN_LEFT,
          weight: 2,
          linefeed: 1));
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Total: ' +
            countotal_Amount(cart: Get.find<CartServices>().cart)
                .value
                .toStringAsFixed(2)
                .toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Cash Received: ' + amountReceived.text,
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Change Amount: ' + change.value.toStringAsFixed(2).toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
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

    await Get.find<BluetoothServices>().bluetooth.printReceipt(config, list);
    config.clear();
    list.clear();
  }

  Future<void> printReceipt_installmentS() async {
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
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Customer Information',
        weight: 0,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Customer Name: ' + customerName.text,
        weight: 0,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));

    for (var i = 0; i < Get.find<CartServices>().cart.length; i++) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: '${Get.find<CartServices>().cart[i].itemName}',
          weight: 1,
          height: 1,
          align: LineText.ALIGN_CENTER,
          linefeed: 1));

      if (Get.find<CartServices>().cart[i].itemHasVariants == 0) {
        list.add(LineText(
            // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
            type: LineText.TYPE_TEXT,
            content:
                '${Get.find<CartServices>().cart[i].item_Quantity.value.toString()} * ${Get.find<CartServices>().cart[i].itemPrice.toString()} = ' +
                    (Get.find<CartServices>().cart[i].item_Quantity.value *
                            double.parse(
                                Get.find<CartServices>().cart[i].itemPrice))
                        .toStringAsFixed(2),
            weight: 0,
            align: LineText.ALIGN_LEFT,
            linefeed: 1));
        if (get_Discount_of_item_or_Variants(
                    price: double.parse(
                        Get.find<CartServices>().cart[i].itemPrice),
                    discount: double.parse(
                        Get.find<CartServices>().cart[i].item_Discount),
                    discounttype:
                        Get.find<CartServices>().cart[i].item_discount_type,
                    quantity:
                        Get.find<CartServices>().cart[i].item_Quantity.value)
                .value !=
            0.0) {
          list.add(LineText(
              // count_total_amount_perItem_no_variants(discounttype: Get.find<CartServices>().cart[i].item_discount_type, discount: double.parse(Get.find<CartServices>().cart[i].item_Discount), quantity: Get.find<CartServices>().cart[i].item_Quantity.value, itemprice: double.parse(Get.find<CartServices>().cart[i].itemPrice));
              type: LineText.TYPE_TEXT,
              content: 'Discount : ' +
                  get_Discount_of_item_or_Variants(
                          price: double.parse(
                              Get.find<CartServices>().cart[i].itemPrice),
                          discount: double.parse(
                              Get.find<CartServices>().cart[i].item_Discount),
                          discounttype: Get.find<CartServices>()
                              .cart[i]
                              .item_discount_type,
                          quantity: Get.find<CartServices>()
                              .cart[i]
                              .item_Quantity
                              .value)
                      .toStringAsFixed(2),
              weight: 0,
              align: LineText.ALIGN_LEFT,
              linefeed: 1));
        }
        // list.add(LineText(
        //     type: LineText.TYPE_TEXT,
        //     content: 'Subtotal : ' +
        //         count_total_amount_perItem_no_variants(
        //                 discounttype:
        //                     Get.find<CartServices>().cart[i].item_discount_type,
        //                 discount: double.parse(
        //                     Get.find<CartServices>().cart[i].item_Discount),
        //                 quantity: Get.find<CartServices>()
        //                     .cart[i]
        //                     .item_Quantity
        //                     .value,
        //                 itemprice: double.parse(
        //                     Get.find<CartServices>().cart[i].itemPrice))
        //             .toStringAsFixed(2),
        //     weight: 0,
        //     align: LineText.ALIGN_LEFT,
        //     linefeed: 1));
      } else {
        for (var z = 0;
            z < Get.find<CartServices>().cart[i].itemVariantList!.length;
            z++) {
          if (Get.find<CartServices>()
                  .cart[i]
                  .itemVariantList![z]
                  .variant_Quantity
                  .value !=
              0) {
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${Get.find<CartServices>().cart[i].itemVariantList![z].variantName}',
                weight: 1,
                height: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            list.add(LineText(
                type: LineText.TYPE_TEXT,
                content:
                    '${Get.find<CartServices>().cart[i].itemVariantList![z].variant_Quantity.value} x ${Get.find<CartServices>().cart[i].itemVariantList![z].variantPrice} = ' +
                        (Get.find<CartServices>()
                                    .cart[i]
                                    .itemVariantList![z]
                                    .variant_Quantity
                                    .value *
                                (double.parse(Get.find<CartServices>()
                                    .cart[i]
                                    .itemVariantList![z]
                                    .variantPrice)))
                            .toStringAsFixed(2)
                            .toString(),
                weight: 0,
                align: LineText.ALIGN_LEFT,
                linefeed: 1));
            if (get_Discount_of_item_or_Variants(
                        price: double.parse(Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variantPrice),
                        quantity: Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variant_Quantity
                            .value,
                        discount: double.parse(Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variant_discount),
                        discounttype: Get.find<CartServices>()
                            .cart[i]
                            .itemVariantList![z]
                            .variant_discount_type)
                    .value !=
                0.0) {
              list.add(LineText(
                  type: LineText.TYPE_TEXT,
                  content: 'Discount:' +
                      get_Discount_of_item_or_Variants(
                              price: double.parse(Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variantPrice),
                              quantity: Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variant_Quantity
                                  .value,
                              discount: double.parse(Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variant_discount),
                              discounttype: Get.find<CartServices>()
                                  .cart[i]
                                  .itemVariantList![z]
                                  .variant_discount_type)
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
            //                 itemprice: double.parse(Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variantPrice),
            //                 quantity: Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variant_Quantity
            //                     .value,
            //                 discount: double.parse(Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variant_discount),
            //                 discounttype: Get.find<CartServices>()
            //                     .cart[i]
            //                     .itemVariantList![z]
            //                     .variant_discount_type)
            //             .toStringAsFixed(2),
            //     weight: 1,
            //     height: 0,
            //     align: LineText.ALIGN_LEFT,
            //     linefeed: 1));
          }
        }
      }
    }
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Subtotal: ' +
            countotal_Amount_with_no_Discount(
                    cart: Get.find<CartServices>().cart)
                .value
                .toStringAsFixed(2)
                .toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(linefeed: 1));
    if (total_Discount().value != 0) {
      list.add(LineText(
          type: LineText.TYPE_TEXT,
          content: 'Discount: ' +
              total_Discount().value.toStringAsFixed(2).toString(),
          align: LineText.ALIGN_LEFT,
          weight: 2,
          linefeed: 1));
    }
    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Total: ' +
            countotal_Amount(cart: Get.find<CartServices>().cart)
                .value
                .toStringAsFixed(2)
                .toString(),
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Days to pay: ${daysTextEditing.text}',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Additional payment:  ${amount_per_Day.value}',
        weight: 2,
        align: LineText.ALIGN_LEFT,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Installment Total Amount:  ${installment_total_amount.value}',
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Cash Received: ' + amountReceived.text,
        align: LineText.ALIGN_LEFT,
        weight: 2,
        linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Change Amount: ' + change.value.toStringAsFixed(2).toString(),
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

    await Get.find<BluetoothServices>().bluetooth.printReceipt(config, list);
    config.clear();
    list.clear();
  }

  showDialog_View_Variants(
      {required BuildContext context,
      required String discountType,
      required double discount,
      required List<ItemVariant> items,
      required String productName}) {
    var sizer = Sizer();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          height: sizer.height(height: 50, context: context),
          width: sizer.width(width: 100, context: context),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              // color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Text(
                productName.toString().capitalizeFirst.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizer.font(fontsize: 15, context: context),
                ),
              ),
              Container(
                  // padding: EdgeInsets.only(
                  //     left: sizer.width(width: 2, context: context),
                  //     right: sizer.width(width: 2, context: context)),
                  child: Divider(
                color: Colors.black,
              )),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return items[index].variantQunatity.value == 0
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(
                                left: sizer.width(width: 1, context: context),
                                right: sizer.width(width: 1, context: context),
                                top:
                                    sizer.height(height: 0.5, context: context),
                              ),
                              child: Container(
                                height:
                                    sizer.height(height: 6, context: context),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          productName.capitalizeFirst
                                                  .toString() +
                                              " " +
                                              items[index]
                                                  .variantName
                                                  .toString()
                                                  .capitalizeFirst
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              items[index]
                                                  .variantQunatity
                                                  .value
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 11,
                                                      context: context)),
                                            ),
                                            Text(
                                              " x ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 11,
                                                      context: context)),
                                            ),
                                            Text(
                                              items[index]
                                                      .variantPrice
                                                      .toString() +
                                                  " = ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 11,
                                                      context: context)),
                                            ),
                                            Text(
                                              "₱ " +
                                                  (items[index]
                                                              .variantQunatity
                                                              .value *
                                                          double.parse(items[
                                                                  index]
                                                              .variantPrice))
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: sizer.font(
                                                      fontsize: 11,
                                                      context: context)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: sizer.width(
                                          width: 100, context: context),
                                      alignment: Alignment.centerRight,
                                      child: discountType ==
                                              "Discount in Amount"
                                          ? Text(
                                              "Discount " +
                                                  "(₱ ${(items[index].variantQunatity.value * discount)})",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[400],
                                                  fontSize: sizer.font(
                                                      fontsize: 9,
                                                      context: context)),
                                            )
                                          : Text(
                                              "Discount " +
                                                  "(${(items[index].variantQunatity.value * discount)}%)",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[400],
                                                  fontSize: sizer.font(
                                                      fontsize: 9,
                                                      context: context)),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 1, context: context),
                    right: sizer.width(width: 1, context: context),
                    top: sizer.height(height: 0.5, context: context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 13, context: context)),
                    ),
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 13, context: context)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
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
                  width: sizer.width(width: 50, context: context),
                  height: sizer.height(height: 5, context: context),
                  child: Text(
                    "OK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 15, context: context),
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

  getback() {
    Get.back();
    Get.back();
  }

  installmentDialog({required BuildContext context, required Sizer sizer}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          padding: EdgeInsets.only(
            left: sizer.width(width: 2, context: context),
            right: sizer.width(width: 2, context: context),
          ),
          height: sizer.height(height: 36, context: context),
          width: sizer.width(width: 20, context: context),
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
                height: sizer.height(height: 2, context: context),
              ),
              Text(
                "How many days do you want to avail this installment?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizer.font(fontsize: 12, context: context),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 3, context: context),
              ),
              Container(
                alignment: Alignment.center,
                // color: Colors.red,
                height: sizer.height(height: 6, context: context),
                width: sizer.width(width: 100, context: context),
                child: TextField(
                  controller: daysTextEditing,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false),
                  onChanged: (value) {
                    if (value.isEmpty) {
                      count_total_installment_amount(days: 0);
                    } else {
                      count_total_installment_amount(days: int.parse(value));
                    }
                  },
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      // contentPadding:
                      //     EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Days",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: sizer.height(height: 6, context: context),
                width: sizer.width(width: 100, context: context),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    )),
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context)),
                child: Obx(
                  () => Text(
                    amount_per_Day.value == 0.0
                        ? "Additional payment"
                        : amount_per_Day.value.toStringAsFixed(2).toString() +
                            " per day",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                      fontSize: sizer.font(fontsize: 10.5, context: context),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sizer.font(fontsize: 12, context: context),
                      ),
                    ),
                    Obx(
                      () => Text(
                        "₱ " +
                            installment_total_amount.value.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 12, context: context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  // padding: EdgeInsets.only(
                  //     left: sizer.width(width: 2, context: context),
                  //     right: sizer.width(width: 2, context: context)),
                  child: Divider(
                color: Colors.black,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      getback();
                    },
                    child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: sizer.width(width: 20, context: context),
                      height: sizer.height(height: 5, context: context),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 15, context: context),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      print(Get.find<BluetoothServices>().bluetoothState);
                      print(Get.find<BluetoothServices>().printerStatus);
                      if (Get.find<BluetoothServices>().bluetoothState == 12 ||
                          Get.find<BluetoothServices>().bluetoothState == 1) {
                        if (Get.find<BluetoothServices>().printerStatus ==
                            "Connected") {
                          printReceipt_installmentS();
                        }
                      }
                      Get.back();
                      create_order(
                          context: context, paymenttype: "Installment");
                    },
                    child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: sizer.width(width: 20, context: context),
                      height: sizer.height(height: 5, context: context),
                      child: Text(
                        "Confirm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 15, context: context),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  setActiveAndInActive({required int discountID}) {
    for (var i = 0; i < Get.find<DiscountServices>().discountList.length; i++) {
      if (discountID ==
          Get.find<DiscountServices>().discountList[i].discountId) {
        Get.find<DiscountServices>().discountList[i].discountActive.value =
            true;
        Get.find<DiscountServices>().discountValue.value =
            double.parse(Get.find<DiscountServices>().discountList[i].discount);
        Get.find<DiscountServices>().discountType.value =
            Get.find<DiscountServices>().discountList[i].discountType.value;
        Get.find<DiscountServices>().discountid.value =
            Get.find<DiscountServices>().discountList[i].discountId;
        discountForCheckOut.value =
            double.parse(Get.find<DiscountServices>().discountList[i].discount);
        discountTypeForCheckout.value =
            Get.find<DiscountServices>().discountList[i].discountType.value;
      } else {
        Get.find<DiscountServices>().discountList[i].discountActive.value =
            false;
      }
    }
  }

  resetAll() {
    for (var i = 0; i < Get.find<DiscountServices>().discountList.length; i++) {
      Get.find<DiscountServices>().discountList[i].discountActive.value = false;
      Get.find<DiscountServices>().discountValue.value = 0.0;
      Get.find<DiscountServices>().discountType.value = "";
      Get.find<DiscountServices>().discountid.value = 0;
    }
    discountForCheckOut.value = 0.0;
  }

  @override
  void onClose() async {
    super.onClose();
  }

  RxDouble total_Discount() {
    var total = originalAmount(cart: Get.find<CartServices>().cart).value -
        discountedAmount(cart: Get.find<CartServices>().cart).value;
    if (discountTypeForCheckout.value == "Amount") {
      print(discountTypeForCheckout.value + " HERE");
      total = total + discountForCheckOut.value;
    } else {
      print(discountTypeForCheckout.value + " HERE");
      total = total +
          ((discountForCheckOut.value / 100) *
              discountedAmount(cart: Get.find<CartServices>().cart).value);
    }
    return total.obs;
  }

  RxDouble discountedAmount({required List<CartList> cart}) {
    var total = 0.0;
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].itemHasVariants == 0) {
        if (cart[i].item_discount_type == "Amount") {
          total = total +
              ((double.parse(cart[i].itemPrice) -
                      double.parse(cart[i].item_Discount)) *
                  cart[i].item_Quantity.value);
        } else {
          total = total +
              ((double.parse(cart[i].itemPrice) -
                      ((double.parse(cart[i].item_Discount) / 100)) *
                          double.parse(cart[i].itemPrice)) *
                  cart[i].item_Quantity.value);
        }
      } else {
        for (var z = 0; z < cart[i].itemVariantList!.length; z++) {
          if (cart[i].itemVariantList![z].variant_discount_type == "Amount") {
            total = total +
                ((double.parse(cart[i].itemVariantList![z].variantPrice) -
                        double.parse(
                            cart[i].itemVariantList![z].variant_discount)) *
                    cart[i].itemVariantList![z].variant_Quantity.value);
          } else {
            total = total +
                ((double.parse(cart[i].itemVariantList![z].variantPrice) -
                        ((double.parse(cart[i]
                                    .itemVariantList![z]
                                    .variant_discount) /
                                100) *
                            double.parse(
                                cart[i].itemVariantList![z].variantPrice))) *
                    cart[i].itemVariantList![z].variant_Quantity.value);
          }
        }
      }
    }

    return total.obs;
  }

  RxDouble originalAmount({required List<CartList> cart}) {
    var total = 0.0;
    for (var i = 0; i < cart.length; i++) {
      if (cart[i].itemHasVariants == 0) {
        total = total +
            (double.parse(cart[i].itemPrice) * cart[i].item_Quantity.value);
      } else {
        for (var z = 0; z < cart[i].itemVariantList!.length; z++) {
          total = total +
              (double.parse(cart[i].itemVariantList![z].variantPrice) *
                  cart[i].itemVariantList![z].variant_Quantity.value);
        }
      }
    }

    return total.obs;
  }

  forlooptextfield(
      {required int variantid,
      required List<ItemVariantList> itemvariantList}) {
    for (var i = 0; i < itemvariantList.length; i++) {
      if (variantid != itemvariantList[i].variantId) {
        itemvariantList[i].variant_Boolean.value = false;
      }
    }
  }

  showdialog_enter_quantity_no_variants(
      {required BuildContext context, required int mainItemID}) {
    Sizer sizer = Sizer();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
            height: sizer.height(height: 15, context: context),
            width: sizer.width(width: 20, context: context),
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: TextField(
                    obscureText: false,
                    controller: enterquantity,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter Quantity",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  // color: Color(0xff01A0C7),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.cyanAccent,
                            Colors.greenAccent,
                            Colors.lightBlue,
                            Colors.tealAccent
                          ]),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        type_quantity_no_Variants(
                            mainItemID: mainItemID,
                            quantity: enterquantity.text);
                        Get.back();
                      },
                      child: Text("Done",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                                  fontSize: sizer.font(
                                      fontsize: 10, context: context))
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            )),
      ),
      barrierDismissible: false,
    );
  }

  showdialog_enter_quantity_has_variants(
      {required BuildContext context,
      required int mainItemID,
      required int variantid}) {
    Sizer sizer = Sizer();
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
            height: sizer.height(height: 15, context: context),
            width: sizer.width(width: 20, context: context),
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: TextField(
                    obscureText: false,
                    controller: enterquantity,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration.collapsed(
                      hintText: "Enter Quantity",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  // color: Color(0xff01A0C7),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.cyanAccent,
                            Colors.greenAccent,
                            Colors.lightBlue,
                            Colors.tealAccent
                          ]),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        type_quantity_has_variant(
                            mainitemid: mainItemID,
                            variantid: variantid,
                            quantity: int.parse(enterquantity.text));
                        Get.back();
                      },
                      child: Text("Done",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                                  fontSize: sizer.font(
                                      fontsize: 10, context: context))
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            )),
      ),
      barrierDismissible: false,
    );
  }
}
