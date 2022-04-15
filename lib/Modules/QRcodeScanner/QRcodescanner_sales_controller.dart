import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobilepos/Modules/Homepage/Homepage_model.dart';
import 'package:mobilepos/Modules/Homepage/homepage_controller.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRcodeScannerSalesController extends GetxController {
  RxBool alreadyScanned = false.obs;
  RxList<FinalItemsList> itemsList = Get.find<HomepageController>().itemsList;
  @override
  void onInit() {
    super.onInit();
  }

  onScanTransactSales(
      {required String itemBarcode, required BuildContext context}) {
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemHasVariants == 0) {
        if (itemsList[i].itemBarcode == itemBarcode) {
          if (double.parse(itemsList[i].itemCount) ==
              itemsList[i].itemQuantity.value) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Maximum count of item reach'),
            ));
          } else {
            Get.find<HomepageController>()
                .add_quantity_no_variants(mainItemID: itemsList[i].itemId);
          }
        }
      } else {
        for (var x = 0; x < itemsList[i].itemListOfVariants.length; x++) {
          if (itemsList[i].itemListOfVariants[x].variant_barcode ==
              itemBarcode) {
            print(itemsList[i].itemId);
            print(itemsList[i].itemListOfVariants[x].variantId);
            if (int.parse(itemsList[i].itemListOfVariants[x].variantCount) ==
                0) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Variant of stock'),
              ));
            } else {
              if (itemsList[i].itemListOfVariants[x].variantQuantity.value ==
                  double.parse(
                      itemsList[i].itemListOfVariants[x].variantCount)) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Maximum count of variant reach'),
                ));
              } else {
                Get.find<HomepageController>().add_quantity_variant(
                  mainItemID: itemsList[i].itemId,
                  variantId: itemsList[i].itemListOfVariants[x].variantId,
                );
              }
            }
          }
        }
      }
    }
    Get.back();
  }
}
