import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobilepos/Modules/Homepage/hompage_view.dart';
import 'package:mobilepos/Modules/Login/Login_api.dart';
import 'package:mobilepos/Modules/Login/Login_model.dart';
import 'package:mobilepos/helpers/storage.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  RxBool isLoadingLogin = false.obs;

  RxBool dontshowPassword = true.obs;
  RxList<Userdata> user = <Userdata>[].obs;

  login(
      {required String username,
      required String password,
      required BuildContext context}) async {
    isLoadingLogin(true);
    var result =
        await LoginApi.get_user(username: username, password: password);
    print(result);
    if (result.length != 0) {
      user.assignAll(result);
      print(user[0].userPassword);
      print(user[0].storeId);
      print(user[0].userEmail);
      print(user[0].userType);
      print(user[0].userId);
      await Get.find<StorageService>().storeusers(
          password: user[0].userPassword,
          storeid: user[0].storeId.toString(),
          username: user[0].userEmail,
          usertype: user[0].userType,
          userid: user[0].userId.toString());
      Get.offAll(() => HomepageView());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User did not exist'),
      ));
    }
    isLoadingLogin(false);
  }
}
