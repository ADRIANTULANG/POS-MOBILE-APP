import 'package:get/get.dart';
import 'package:mobilepos/Model/CartModel.dart';

class CartServices extends GetxService {
  @override
  void onInit() {
    print("CartServices Initialize");
    super.onInit();
  }

  RxList<CartList> cart = <CartList>[].obs;
}
