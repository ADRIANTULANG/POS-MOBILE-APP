import 'package:get/get.dart';
import 'package:mobilepos/Model/History.dart';
import 'package:mobilepos/helpers/Discount_helper.dart';

class TransactionVariantsDetailsController extends GetxController {
  final DiscountHelper cal = DiscountHelper();
  RxList<ItemVariant> variantList = <ItemVariant>[].obs;
  RxBool isLoading = true.obs;
  RxDouble itemDiscount = 0.0.obs;
  RxString discountType = "".obs;
  @override
  void onInit() async {
    variantList.assignAll(await Get.arguments['variantsList']);
    itemDiscount.value =
        await double.parse(Get.arguments['itemDiscount'].toString());
    discountType.value = await Get.arguments['discountType'].toString();
    isLoading(false);
    super.onInit();
  }

  RxString totaDiscountOfVariant(
      {required double variantPrice, required int variantQuantity}) {
    // var total = variantPrice * variantQuantity;
    // var totalWithDiscount =
    //     (variantPrice - itemDiscount.value) * variantQuantity;
    // var result = total - totalWithDiscount;
    var result = 0.0;
    if (discountType.value == "Discount in Amount") {
      result = (variantPrice * variantQuantity) -
          ((variantPrice - itemDiscount.value) * variantQuantity);
    } else {
      result = (variantPrice * variantQuantity) -
          (cal.getDiscountedPrice(
              itemPrice: variantPrice,
              discountInPercent: itemDiscount.value,
              quantity: variantQuantity));
    }
    return result.toStringAsFixed(2).toString().obs;
  }
}
