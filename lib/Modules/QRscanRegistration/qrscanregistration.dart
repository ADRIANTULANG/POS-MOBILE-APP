// import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Items/Item_controller.dart';
import 'package:mobilepos/Modules/QRscanRegistration/qrscanregistration_controller.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanforRegistrationView extends StatefulWidget {
  QRScanforRegistrationView({required this.isVariant});
  final bool isVariant;
  @override
  State<StatefulWidget> createState() =>
      _QRScanforRegistrationViewState(isVariant: isVariant);
}

class _QRScanforRegistrationViewState extends State<QRScanforRegistrationView> {
  _QRScanforRegistrationViewState({required this.isVariant});
  final bool isVariant;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrcodeController = Get.put(QRcodeController());
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    // Barcode Type: ${describeEnum(result!.format)}
                    Text('   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                print(snapshot.data);
                                RxBool isOn = false.obs;
                                if (snapshot.data == true) {
                                  isOn.value = true;
                                } else {
                                  isOn.value = false;
                                }
                                return Obx(() => isOn.value == true
                                    ? Text('Flash: On')
                                    : Text('Flash: Off'));
                              },
                            )),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.all(8),
                      //   child: ElevatedButton(
                      //       onPressed: () async {
                      //         await controller?.flipCamera();
                      //         setState(() {});
                      //       },
                      //       child: FutureBuilder(
                      //         future: controller?.getCameraInfo(),
                      //         builder: (context, snapshot) {
                      //           if (snapshot.data != null) {
                      //             return Text(
                      //                 'Camera facing ${describeEnum(snapshot.data!)}');
                      //           } else {
                      //             return const Text('loading');
                      //           }
                      //         },
                      //       )),
                      // )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Column(
  //       children: <Widget>[
  //         Expanded(flex: 4, child: _buildQrView(context)),
  //         Expanded(
  //           flex: 1,
  //           child: FittedBox(
  //             fit: BoxFit.contain,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: <Widget>[
  //                 // if (result != null)
  //                 //   Text(
  //                 //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
  //                 // else
  //                 //   Text('Scan a code'),
  //                 // Row(
  //                 //   mainAxisAlignment: MainAxisAlignment.center,
  //                 //   crossAxisAlignment: CrossAxisAlignment.center,
  //                 //   children: <Widget>[
  //                 //     Container(
  //                 //       margin: EdgeInsets.all(8),
  //                 //       child: ElevatedButton(
  //                 //           onPressed: () async {
  //                 //             await controller?.toggleFlash();
  //                 //             setState(() {});
  //                 //           },
  //                 //           child: FutureBuilder(
  //                 //             future: controller?.getFlashStatus(),
  //                 //             builder: (context, snapshot) {
  //                 //               return Text('Flash: ${snapshot.data}');
  //                 //             },
  //                 //           )),
  //                 //     ),
  //                 //     Container(
  //                 //       margin: EdgeInsets.all(8),
  //                 //       child: ElevatedButton(
  //                 //           onPressed: () async {
  //                 //             await controller?.flipCamera();
  //                 //             setState(() {});
  //                 //           },
  //                 //           child: FutureBuilder(
  //                 //             future: controller?.getCameraInfo(),
  //                 //             builder: (context, snapshot) {
  //                 //               if (snapshot.data != null) {
  //                 //                 return Text(
  //                 //                     'Camera facing ${describeEnum(snapshot.data!)}');
  //                 //               } else {
  //                 //                 return Text('loading');
  //                 //               }
  //                 //             },
  //                 //           )),
  //                 //     )
  //                 //   ],
  //                 // ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: <Widget>[
  //                     // Container(
  //                     //   margin: EdgeInsets.all(8),
  //                     //   child: ElevatedButton(
  //                     //     onPressed: () async {
  //                     //       await controller?.pauseCamera();
  //                     //     },
  //                     //     child: Text('pause', style: TextStyle(fontSize: 20)),
  //                     //   ),
  //                     // ),
  //                     // Container(
  //                     //   margin: EdgeInsets.all(8),
  //                     //   child: ElevatedButton(
  //                     //     onPressed: () async {
  //                     //       await controller?.resumeCamera();
  //                     //     },
  //                     //     child: Text('resume', style: TextStyle(fontSize: 20)),
  //                     //   ),
  //                     // )
  //                     Container(
  //                       margin: EdgeInsets.all(8),
  //                       child: Obx(
  //                         () => ElevatedButton(
  //                           onPressed: () async {
  //                             if (qrcodeController.alreadyScanned.value ==
  //                                 false) {
  //                             } else {
  //                               qrcodeController.alreadyScanned.value = false;
  //                             }
  //                           },
  //                           child:
  //                               qrcodeController.alreadyScanned.value == false
  //                                   ? Text('scanning..',
  //                                       style: TextStyle(fontSize: 20))
  //                                   : Text('scan again',
  //                                       style: TextStyle(fontSize: 20)),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _buildQrView(BuildContext context) {
    var sizer = Sizer();
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    // var scanArea = (MediaQuery.of(context).size.width < 400 ||
    //         MediaQuery.of(context).size.height < 400)
    //     ? 150.0
    //     : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutHeight: sizer.height(height: 70, context: context),
        cutOutWidth: sizer.width(width: 96, context: context),
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result == null) {
        } else {
          if (qrcodeController.alreadyScanned.value == true) {
          } else {
            qrcodeController.alreadyScanned.value = true;
            if (isVariant == true) {
              Get.find<ItemController>().variantBarcode.text =
                  result!.code.toString();
              Get.back();
            } else {
              Get.find<ItemController>().itemBarcode.text =
                  result!.code.toString();
              Get.back();
            }
          }
        }
        print(result!.code);
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    qrcodeController.dispose();
    super.dispose();
  }
}
