import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/SplashScreen/Splashscreen_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobilepos/helpers/CartServices.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/storage.dart';

import 'helpers/connectivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ConnectivityService());
  await Get.put(StorageService());
  await Get.put(CartServices());
  Get.find<ConnectivityService>().checkConnection();

  Get.put(BluetoothServices());
  WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) async {
    await Get.find<BluetoothServices>().initBluetooth();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      title: 'Mobile POS',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Splashscreen(),
    );
  }
}
