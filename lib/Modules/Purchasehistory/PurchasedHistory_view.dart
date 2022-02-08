import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Purchasehistory/PurchasedHistory_controller.dart';
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_view.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/connectivity.dart';

import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';

class PurchasedHistoryView extends GetView<PurchasedHistoryController> {
  const PurchasedHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PurchasedHistoryController());
    var sizer = Sizer();
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
          "PURCHASED  HISTORY",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.find<ConnectivityService>().hasConnection.value == true) {
                controller.save_transactions_into_database(context: context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Please turn on the internet and restart the app'),
                ));
              }
            },
            icon: Icon(Icons.sync_outlined),
          ),
          SizedBox(
            width: sizer.width(width: 2, context: context),
          )
          // PopupMenuButton(
          //     itemBuilder: (context) => [
          //           PopupMenuItem(
          //             child: GestureDetector(
          //               onTap: () {
          //                 if (controller.isSelect.value == false) {
          //                   controller.isSelect.value = true;
          //                   Get.back();
          //                 } else {
          //                   controller.isSelect.value = false;
          //                   Get.back();
          //                 }
          //               },
          //               child: Container(
          //                 height: sizer.height(height: 5, context: context),
          //                 // color: Colors.red,
          //                 child: Row(
          //                   children: [
          //                     Icon(Icons.circle,
          //                         color: Colors.blue,
          //                         size: sizer.font(
          //                             fontsize: 10, context: context)),
          //                     SizedBox(
          //                       width: sizer.width(width: 2, context: context),
          //                     ),
          //                     Text("Select"),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             value: 1,
          //           ),
          //           PopupMenuItem(
          //             child: GestureDetector(
          //               onTap: () {
          //                 // if (controller.isSelect.value == false) {
          //                 //   controller.isSelect.value = true;
          //                 //   controller.selectAll();
          //                 //   Get.back();
          //                 // } else {
          //                 //   controller.isSelect.value = false;
          //                 //   controller.unSelectAll();
          //                 //   Get.back();
          //                 // }
          //               },
          //               child: Container(
          //                 height: sizer.height(height: 5, context: context),
          //                 child: Row(
          //                   children: [
          //                     Icon(Icons.circle,
          //                         color: Colors.blue,
          //                         size: sizer.font(
          //                             fontsize: 10, context: context)),
          //                     SizedBox(
          //                       width: sizer.width(width: 2, context: context),
          //                     ),
          //                     Text("Select All"),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             value: 2,
          //           )
          //         ])
        ],
        // leading: Icon(Icons.),
      ),
      body: Container(
        color: Colors.grey[200],
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                height: sizer.height(height: 7, context: context),
                width: sizer.width(width: 100, context: context),
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: TextField(
                  onChanged: (value) {
                    controller.onSearch(listValueToSearch: value);
                  },
                  controller: controller.searchField,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                )),
            Expanded(
              child: Obx(
                () => controller.isLoadingHistory.value == true
                    ? Center(
                        child: SpinKitThreeBounce(
                          color: Colors.teal[300],
                          size: sizer.font(fontsize: 30, context: context),
                        ),
                      )
                    : controller.historyList.isEmpty
                        ? Center(
                            child: Text("No Purchase History at the moment."),
                          )
                        : ListView.builder(
                            itemCount: controller.historyList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(() => TransactionDetailsView(),
                                      arguments: {
                                        'ordernumber': controller
                                            .historyList[index].ordernumber,
                                        'additional_checkout_discount':
                                            double.parse(controller
                                                .historyList[index]
                                                .additionalCheckoutDiscount),
                                        'additional_checkout_discount_type':
                                            controller.historyList[index]
                                                .additionalCheckoutDiscountType,
                                        'order_payment_type': controller
                                            .historyList[index]
                                            .orderPaymentType,
                                        'installment_Days_to_pay': controller
                                            .historyList[index]
                                            .daysOfInstallment,
                                        'installment_percent_value': controller
                                            .historyList[index]
                                            .installmentPercentValue,
                                      });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: sizer.width(
                                          width: 2, context: context),
                                      right: sizer.width(
                                          width: 2, context: context)),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: sizer.height(
                                            height: 0.5, context: context),
                                      ),
                                      Container(
                                        height: sizer.height(
                                            height: 5, context: context),
                                        width: sizer.width(
                                            width: 100, context: context),
                                        padding: EdgeInsets.only(
                                            left: sizer.width(
                                                width: 2, context: context),
                                            right: sizer.width(
                                                width: 2, context: context)),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Obx(
                                                  () =>
                                                      controller.isSelect
                                                                  .value ==
                                                              true
                                                          ? Checkbox(
                                                              checkColor:
                                                                  Colors.white,
                                                              activeColor: controller
                                                                          .historyList[
                                                                              index]
                                                                          .boolean
                                                                          .value ==
                                                                      false
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .lightBlue,
                                                              value: controller
                                                                  .historyList[
                                                                      index]
                                                                  .boolean
                                                                  .value,
                                                              onChanged:
                                                                  (value) {
                                                                if (controller
                                                                        .historyList[
                                                                            index]
                                                                        .boolean
                                                                        .value ==
                                                                    true) {
                                                                  controller
                                                                      .historyList[
                                                                          index]
                                                                      .boolean
                                                                      .value = false;
                                                                  Get.find<StorageService>()
                                                                          .box
                                                                          .read(
                                                                              'history')[index]
                                                                      [
                                                                      'boolean'] = false;
                                                                } else {
                                                                  controller
                                                                      .historyList[
                                                                          index]
                                                                      .boolean
                                                                      .value = true;
                                                                  Get.find<StorageService>()
                                                                          .box
                                                                          .read(
                                                                              'history')[index]
                                                                      [
                                                                      'boolean'] = true;
                                                                }
                                                                print(controller
                                                                    .historyList[
                                                                        index]
                                                                    .boolean
                                                                    .value);
                                                              },
                                                            )
                                                          : SizedBox(),
                                                ),
                                                // Container(
                                                //   constraints: BoxConstraints(
                                                //     minWidth: sizer.width(
                                                //         width: 6,
                                                //         context: context),
                                                //     maxWidth: sizer.width(
                                                //         width: 10,
                                                //         context: context),
                                                //   ),
                                                //   height: sizer.height(
                                                //       height: 3,
                                                //       context: context),
                                                //   alignment: Alignment.center,
                                                //   padding: EdgeInsets.only(
                                                //       left: sizer.width(
                                                //           width: 1,
                                                //           context: context),
                                                //       right: sizer.width(
                                                //           width: 1,
                                                //           context: context)),
                                                //   decoration: BoxDecoration(
                                                //       gradient: LinearGradient(
                                                //           begin: Alignment
                                                //               .bottomLeft,
                                                //           end: Alignment
                                                //               .topRight,
                                                //           colors: [
                                                //             Colors.cyanAccent,
                                                //             Colors.greenAccent,
                                                //             Colors.lightBlue,
                                                //             Colors.tealAccent
                                                //           ]),
                                                //       // color: Colors.blue,
                                                //       borderRadius:
                                                //           BorderRadius.all(
                                                //               Radius.circular(
                                                //                   10))),
                                                //   child: Text(
                                                //     controller
                                                //         .historyList[index]
                                                //         .orderid
                                                //         .toString(),
                                                //     style: TextStyle(
                                                //         fontWeight:
                                                //             FontWeight.w700,
                                                //         color: Colors.white,
                                                //         fontSize: sizer.font(
                                                //             fontsize: 11,
                                                //             context: context)),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: sizer.width(
                                                      width: 2,
                                                      context: context),
                                                ),
                                                Container(
                                                  height: sizer.height(
                                                      height: 5,
                                                      context: context),
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          controller
                                                              .historyList[
                                                                  index]
                                                              .ordernumber,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: sizer.font(
                                                                  fontsize: 11,
                                                                  context:
                                                                      context)),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          controller
                                                                  .historyList[
                                                                      index]
                                                                  .datetime
                                                                  .month
                                                                  .toString() +
                                                              "-" +
                                                              controller
                                                                  .historyList[
                                                                      index]
                                                                  .datetime
                                                                  .day
                                                                  .toString() +
                                                              "-" +
                                                              controller
                                                                  .historyList[
                                                                      index]
                                                                  .datetime
                                                                  .year
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: sizer.font(
                                                                  fontsize: 7,
                                                                  context:
                                                                      context)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.arrow_forward_ios)
                                            // Container(
                                            //   child: Row(
                                            //     children: [
                                            //       IconButton(
                                            //         color: Colors.red,
                                            //         onPressed: () {
                                            //           controller.deleteItem(index: index);
                                            //         },
                                            //         icon: Icon(Icons.delete),
                                            //       ),
                                            //       IconButton(
                                            //         color: Colors.blue,
                                            //         onPressed: () {
                                            //           controller.showGetDialog_update(
                                            //               context: context, index: index);
                                            //         },
                                            //         icon: Icon(Icons.edit),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: sizer.height(
                                            height: 1, context: context),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Obx(
              () => controller.isSelect.value == false
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                          left: sizer.width(width: 3, context: context),
                          right: sizer.width(width: 3, context: context)),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.lightBlue,
                        child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              // controller.deleteSelectedItem();
                            },
                            child: Icon(Icons.delete_sharp)),
                      ),
                    ),
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(10),
        child: Material(
          elevation: 5.0,

          borderRadius: BorderRadius.circular(30.0),
          // color: Gradient.linear(from, to, colors),
          child: Ink(
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
              borderRadius: BorderRadius.all(Radius.circular(80.0)),
            ),
            child: MaterialButton(
              // color:
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                if (Get.find<ConnectivityService>().hasConnection.value ==
                    true) {
                  if (Get.find<BluetoothServices>().bluetoothState == 12 ||
                      Get.find<BluetoothServices>().bluetoothState == 1) {
                    if (Get.find<BluetoothServices>().printerStatus ==
                        "Connected") {
                      controller.print_daily_sales();
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Open Internet and Restart the app.'),
                  ));
                }
              },
              child: Text("PRINT DAILY SALES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                          fontSize: sizer.font(fontsize: 10, context: context))
                      .copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
