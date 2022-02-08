import 'dart:async';

import 'package:get/get.dart';

import 'package:mobilepos/Modules/Homepage/hompage_view.dart';
import 'package:mobilepos/Modules/Login/login_view.dart';

import 'package:mobilepos/helpers/storage.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    timerToNavigate();
    super.onInit();
  }

  timerToNavigate() async {
    Timer(Duration(seconds: 5), () async {
      if (Get.find<StorageService>().box.read('userid') == null) {
        Get.offAll(() => LoginView());
      } else {
        Get.offAll(() => HomepageView());
      }
    });
  }
}
