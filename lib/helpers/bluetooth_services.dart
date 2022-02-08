import 'dart:convert';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Model/printerModel.dart';

class BluetoothServices extends GetxService {
  BluetoothPrint bluetooth = BluetoothPrint.instance;
  BluetoothDevice? printer;
  bool isConnectedToPrinter = false;
  String printerStatus = '';
  RxInt bluetoothState = 0.obs;

  RxList<PrinterModel> rxPrinterList = <PrinterModel>[].obs;

  List<BluetoothDevice> listofprinters = [];

  Future<void> initBluetooth() async {
    bool? isConnected = await bluetooth.isConnected;

    try {
      if (bluetooth.isScanning == true) {
      } else {
        bluetooth.state.listen((state) {
          bluetoothState.value = state;

          switch (state) {
            case BluetoothPrint.CONNECTED:
              isConnectedToPrinter = true;
              printerStatus = 'Connected';
              print(" CONNECTED TO A PRINTER");

              break;
            case BluetoothPrint.DISCONNECTED:
              isConnectedToPrinter = false;
              printerStatus = 'Disconnected';
              print(" DISCONNECTED TO A PRINTER");
              break;
            default:
              break;
          }
          print("state: ${state.toString()}");
          print("status: ${printerStatus.toString()}");
          print("connected to printer ? $isConnectedToPrinter");
        });
      }

      if (isConnected!) {
        isConnectedToPrinter = true;
        printerStatus = 'Connected';
      }
      if (bluetoothState.value == 12) {
        print("state is now 12");
        bluetooth.startScan(timeout: const Duration(seconds: 1));
        getPrinters();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getPrinters() async {
    bluetooth.scanResults.listen((data) {
      var list = [];
      listofprinters.assignAll(data);
      print(listofprinters);

      for (var i = 0; i < listofprinters.length; i++) {
        Map map = {
          "address": listofprinters[i].address,
          "name": listofprinters[i].name,
          "connected": listofprinters[i].connected,
          "type": listofprinters[i].type,
          "bools": listofprinters[i].connected,
        };
        list.add(map);
      }

      rxPrinterList.assignAll(printerModelFromJson(jsonEncode(list)));
    });
  }
}
