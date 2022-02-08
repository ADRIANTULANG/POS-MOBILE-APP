import 'dart:io';

import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  RxBool hasConnection = false.obs;

  checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      print("has internet connection");
      hasConnection(true);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      hasConnection(false);
      print("no internet connection");
      return false;
    }
  }
}
