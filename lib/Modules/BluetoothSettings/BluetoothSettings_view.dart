import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/BluetoothSettings/BluetoothSetting_controller.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/sizer.dart';

class BluetoothSettingsView extends GetView<BluetoothController> {
  const BluetoothSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BluetoothController());
    Sizer sizer = Sizer();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.cyanAccent,
                  Colors.greenAccent,
                  Colors.lightBlue,
                  Colors.tealAccent
                ]),
          ),
        ),
        title: Text(
          "PRINTER SETTINGS",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Get.find<BluetoothServices>()
          //           .bluetooth
          //           .startScan(timeout: const Duration(seconds: 1));
          //     },
          //     icon: Icon(Icons.bluetooth_searching)),
          SizedBox(
            width: sizer.width(width: 2, context: context),
          )
        ],
        // leading: Icon(Icons.),
      ),
      body: Container(
        color: Colors.grey[350],
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        padding: EdgeInsets.only(
          left: sizer.width(width: 2, context: context),
          right: sizer.width(width: 2, context: context),
          top: sizer.height(height: 1, context: context),
          bottom: sizer.height(height: 1, context: context),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          child: Obx(
            () => controller.isReadyToConnect.value == true
                ? Get.find<BluetoothServices>().rxPrinterList.isEmpty ||
                        Get.find<BluetoothServices>().bluetoothState == 10
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No Available Printer or Bluetooth \n is off please turn it on.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: sizer.height(height: 1, context: context),
                            ),
                            Container(
                              width: sizer.width(width: 40, context: context),
                              height: sizer.height(height: 5, context: context),
                              child: Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                // color: Colors.blue,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          Colors.cyanAccent,
                                          Colors.lightBlue,
                                          Colors.cyanAccent,
                                          Colors.greenAccent,
                                          Colors.lightBlue,
                                          Colors.tealAccent
                                        ]),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(32.0)),
                                  ),
                                  child: MaterialButton(
                                    minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () async {
                                      // Get.find<BluetoothServices>()
                                      //     .bluetooth
                                      //     .startScan(
                                      //         timeout:
                                      //             const Duration(seconds: 1));
                                      Get.find<BluetoothServices>()
                                          .initBluetooth();
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.bluetooth_searching_outlined,
                                          color: Colors.white,
                                          size: sizer.font(
                                              fontsize: 16, context: context),
                                        ),
                                        SizedBox(
                                          width: sizer.width(
                                              width: 1, context: context),
                                        ),
                                        Text("Scan",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                    fontSize: sizer.font(
                                                        fontsize: 12,
                                                        context: context))
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            Get.find<BluetoothServices>().rxPrinterList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: EdgeInsets.only(
                                top: sizer.width(width: 4, context: context),
                                left: sizer.width(width: 3, context: context),
                                right: sizer.width(width: 5, context: context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Obx(
                                      () => Icon(
                                        Icons.print_rounded,
                                        color: Get.find<BluetoothServices>()
                                                    .rxPrinterList[index]
                                                    .bools
                                                    .value ==
                                                false
                                            ? Colors.black
                                            : Colors.teal[400],
                                      ),
                                    ),
                                    SizedBox(
                                      width: sizer.width(
                                          width: 2, context: context),
                                    ),
                                    Text(
                                      Get.find<BluetoothServices>()
                                          .rxPrinterList[index]
                                          .name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: sizer.font(
                                              fontsize: 12, context: context)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: sizer.width(
                                          width: 25, context: context),
                                      height: sizer.height(
                                          height: 3, context: context),
                                      child: Material(
                                        elevation: 5.0,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        // color: Colors.blue,
                                        child: Obx(
                                          () => Ink(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.bottomLeft,
                                                  end: Alignment.topRight,
                                                  colors:
                                                      Get.find<BluetoothServices>()
                                                                  .rxPrinterList[
                                                                      index]
                                                                  .bools
                                                                  .value ==
                                                              false
                                                          ? [
                                                              Colors.grey,
                                                              Colors.grey,
                                                              Colors.white38,
                                                            ]
                                                          : [
                                                              Colors.cyanAccent,
                                                              Colors.lightBlue,
                                                              Colors.cyanAccent,
                                                              Colors
                                                                  .greenAccent,
                                                              Colors.lightBlue,
                                                              Colors.tealAccent
                                                            ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0)),
                                            ),
                                            child: MaterialButton(
                                              minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              onPressed: () async {
                                                print(Get.find<
                                                        BluetoothServices>()
                                                    .isConnectedToPrinter
                                                    .toString());
                                                if (controller.isReadyToConnect
                                                        .value ==
                                                    true) {
                                                  if (Get.find<
                                                              BluetoothServices>()
                                                          .rxPrinterList[index]
                                                          .bools
                                                          .value ==
                                                      false) {
                                                    Get.find<
                                                            BluetoothServices>()
                                                        .printer = Get.find<
                                                            BluetoothServices>()
                                                        .listofprinters[index];
                                                    Get.find<
                                                            BluetoothServices>()
                                                        .rxPrinterList[index]
                                                        .bools
                                                        .value = true;
                                                    if (Get.find<
                                                                BluetoothServices>()
                                                            .printer !=
                                                        null) {
                                                      await Get.find<
                                                              BluetoothServices>()
                                                          .bluetooth
                                                          .connect(Get.find<
                                                                  BluetoothServices>()
                                                              .listofprinters[index]);
                                                    } else {}
                                                  } else {
                                                    controller.isClickablenow
                                                        .value = false;
                                                    Get.find<
                                                            BluetoothServices>()
                                                        .rxPrinterList[index]
                                                        .bools
                                                        .value = false;
                                                    Get.find<
                                                            BluetoothServices>()
                                                        .bluetooth
                                                        .disconnect();
                                                    controller.canClick();
                                                  }
                                                }
                                              },
                                              child: Obx(
                                                () => Text(
                                                    Get.find<BluetoothServices>()
                                                                .rxPrinterList[
                                                                    index]
                                                                .bools
                                                                .value ==
                                                            false
                                                        ? "Connect"
                                                        : "Connected",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                            fontSize: sizer.font(
                                                                fontsize: 10,
                                                                context:
                                                                    context))
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                : Center(
                    child: Text("Scanning Printer"),
                  ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: sizer.width(width: 2, context: context),
          right: sizer.width(width: 2, context: context),
        ),
        color: Colors.grey[350],
        child: GestureDetector(
          onTap: () {
            print(Get.find<BluetoothServices>().bluetoothState);
            print(Get.find<BluetoothServices>().printerStatus);
            if (Get.find<BluetoothServices>().bluetoothState == 12 ||
                Get.find<BluetoothServices>().bluetoothState == 1) {
              if (Get.find<BluetoothServices>().printerStatus == "Connected") {
                controller.testprint();
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.cyanAccent,
                      Colors.greenAccent,
                      Colors.lightBlue,
                      Colors.tealAccent
                    ]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            alignment: Alignment.center,
            height: sizer.height(height: 8, context: context),
            width: sizer.width(width: 100, context: context),
            child: Text(
              "TEST PRINT",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: sizer.font(fontsize: 15, context: context)),
            ),
          ),
        ),
      ),
    );
  }
}
