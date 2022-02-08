import 'dart:async';

// import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:get/get.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';

class BluetoothController extends GetxController {
  RxBool isReadyToConnect = false.obs;
  Timer? timerForReadyClicking;
  // BluetoothPrint bluetooth = BluetoothPrint.instance;
  RxBool isClickablenow = true.obs;
  Timer? timertoClick;

  @override
  void onInit() {
    super.onInit();
    timerForReadyClicking = Timer(Duration(seconds: 5), () {
      isReadyToConnect.value = true;
    });
  }

  canClick() {
    timertoClick = Timer(Duration(seconds: 3), () {
      isClickablenow.value = true;
    });
  }

  List<LineText> list = [];
  Map<String, dynamic> config = {};

  Future<void> testprint() async {
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'Mobile POS Prototype',
        weight: 1,
        align: LineText.ALIGN_CENTER,
        linefeed: 1));

    list.add(LineText(linefeed: 1));
    list.add(LineText(
        type: LineText.TYPE_TEXT,
        content: 'TEST PRINT',
        align: LineText.ALIGN_CENTER,
        weight: 5,
        linefeed: 1));

    await Get.find<BluetoothServices>().bluetooth.printReceipt(config, list);
    config.clear();
    list.clear();
  }
}
