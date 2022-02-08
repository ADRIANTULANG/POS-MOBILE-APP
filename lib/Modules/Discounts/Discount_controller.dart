import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Discounts/Discount_api.dart';
import 'package:mobilepos/helpers/DiscountServices.dart';

class DiscountController extends GetxController {
  TextEditingController discountName = TextEditingController();
  TextEditingController discountValue = TextEditingController();
  RxString discounttypevalue = ''.obs;

  List discounttypes = ['Amount', 'Percent'];
  RxBool isLoading = false.obs;
  RxBool isLoadingUpdate = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

// discountid
  create_Discount({required BuildContext context}) async {
    isLoading(true);
    var result = await DiscountApi.add_Discount(
        discountname: discountName.text,
        discountvalue: discountValue.text,
        discounttype: discounttypevalue.value);
    print(result);
    isLoading(false);
    if (result == true) {
      Get.find<DiscountServices>().get_Discount_remain_active();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Discount Created'),
      ));
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
      Get.find<DiscountServices>().get_Discount_remain_active();
    }
  }

  update_discount(
      {required int discountid, required BuildContext context}) async {
    isLoadingUpdate(true);
    var result = await DiscountApi.update_Discount(
        discountid: discountid.toString(),
        discount: discountValue.text,
        discounttype: discounttypevalue.value.toString(),
        discountname: discountName.text);
    print(result);
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Discount Updated'),
      ));
      Get.find<DiscountServices>().get_Discount_remain_active();
    }
    isLoadingUpdate(true);
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
  }
}
