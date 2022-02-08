import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Discounts/Discount_api.dart';
import 'package:mobilepos/Modules/Discounts/Discount_model.dart';
import 'package:mobilepos/helpers/connectivity.dart';
import 'package:mobilepos/helpers/storage.dart';

class DiscountServices extends GetxService {
  RxList<Discount> discountList = <Discount>[].obs;

  @override
  void onInit() async {
    if (Get.find<ConnectivityService>().hasConnection.value == true) {
      await ge_all_Discount();
    } else {
      await get_all_discounts_offline_mode();
    }
    super.onInit();
  }

  RxDouble discountValue = 0.0.obs;
  RxString discountType = "".obs;
  RxInt discountid = 0.obs;

  ge_all_Discount() async {
    // var res = await DiscountApi.samples();
    var result = await DiscountApi.get_All_Discount();

    var partialList = [];
    discountList.assignAll(result);
    for (var i = 0; i < discountList.length; i++) {
      Map map = {
        "discount_name": discountList[i].discountName,
        "discount": discountList[i].discount,
        "discount_type": discountList[i].discountType.value,
        "discount_creator_id": discountList[i].discountCreatorId,
        "discount_store_id": discountList[i].discountStoreId,
        "discount_id": discountList[i].discountId,
      };

      partialList.add(map);
    }
    Get.find<StorageService>()
        .setOfflineDiscounts(listofdiscounts: partialList);
  }

  get_all_discounts_offline_mode() {
    var res;
    if (Get.find<StorageService>().box.read('listofdiscounts') != null) {
      res = discountFromJson(
          jsonEncode(Get.find<StorageService>().box.read('listofdiscounts')));
    } else {
      res = <Discount>[].obs;
    }
    discountList.assignAll(res);
  }

  get_Discount_remain_active() async {
    var result = await DiscountApi.get_All_Discount();
    discountList.assignAll(result);

    for (var i = 0; i < discountList.length; i++) {
      if (discountid.value == discountList[i].discountId &&
          discountType.value == discountList[i].discountType.value &&
          discountValue.value == double.parse(discountList[i].discount)) {
        discountList[i].discountActive.value = true;
        Get.find<DiscountServices>().discountList[i].discountActive.value =
            true;
        discountValue.value = double.parse(discountList[i].discount);
        discountType.value = discountList[i].discountType.value;
        discountid.value = discountList[i].discountId;
      }
    }
  }

  delete_Discount(
      {required int discountid, required BuildContext context}) async {
    var result = await DiscountApi.delete_discount(discountid: discountid);
    print(result);
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Discount Deleted'),
      ));
      get_Discount_remain_active();
    }
  }

  setActiveAndInActive({required int discountID}) {
    for (var i = 0; i < discountList.length; i++) {
      if (discountID == discountList[i].discountId) {
        discountList[i].discountActive.value = true;
        discountValue.value = double.parse(discountList[i].discount);
        discountType.value = discountList[i].discountType.value;
        discountid.value = discountList[i].discountId;
      } else {
        discountList[i].discountActive.value = false;
      }
    }
  }

  resetAll() {
    for (var i = 0; i < discountList.length; i++) {
      discountList[i].discountActive.value = false;
      discountValue.value = 0.0;
      discountType.value = "";
      discountid.value = 0;
    }
  }
}
