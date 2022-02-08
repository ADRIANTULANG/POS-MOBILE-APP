import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/SplashScreen/Spashscreen_controller.dart';
import 'package:mobilepos/helpers/sizer.dart';

class Splashscreen extends GetView<SplashscreenController> {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizer = Sizer();
    Get.put(SplashscreenController());
    return Scaffold(
      body: Container(
        // color: Colors.red,
        alignment: Alignment.center,
        height: sizer.height(context: context, height: 100),
        width: sizer.width(context: context, width: 100),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/splash.png"),
          ),
        ),
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
