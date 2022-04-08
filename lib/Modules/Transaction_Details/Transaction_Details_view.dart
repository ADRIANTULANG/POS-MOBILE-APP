import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_Controller.dart';
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_variants_view.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/connectivity.dart';
// import 'package:mobilepos/Modules/Transaction_Details/sample_prototype.dart';

import 'package:mobilepos/helpers/sizer.dart';

class TransactionDetailsView extends GetView<TransactionDetailsController> {
  const TransactionDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionDetailsController());
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
          "TRANSACTION DETAILS",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: sizer.height(height: 90, context: context),
          width: sizer.width(width: 100, context: context),
          child: Column(
            children: [
              SizedBox(height: sizer.height(height: 1, context: context)),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: controller.finalItemsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ListTile(
                          onTap: () {
                            if (controller
                                    .finalItemsList[index].itemHasVariants ==
                                0) {
                            } else {
                              Get.to(() => ViewVariants(
                                    variantList: controller
                                        .finalItemsList[index]
                                        .itemListOfVariants
                                        .obs,
                                  ));
                            }
                          },
                          leading: Obx(
                            () => controller.finalItemsList[index]
                                        .itemHasVariants ==
                                    0
                                ? Checkbox(
                                    value: controller.finalItemsList[index]
                                        .checkboxbool.value,
                                    activeColor: Colors.blueAccent,
                                    onChanged: (bool? value) {
                                      if (controller.finalItemsList[index]
                                              .checkboxbool.value ==
                                          false) {
                                        controller.finalItemsList[index]
                                            .checkboxbool.value = true;
                                      } else {
                                        controller.finalItemsList[index]
                                            .checkboxbool.value = false;
                                      }
                                      print(controller.finalItemsList[index]
                                          .checkboxbool.value);
                                    },
                                  )
                                : SizedBox(),
                          ),
                          title:
                              Text(controller.finalItemsList[index].itemName),
                          subtitle: controller
                                      .finalItemsList[index].itemHasVariants ==
                                  1
                              ? Text(controller
                                      .count_total_for_has_variants(
                                          variantList: controller
                                              .finalItemsList[index]
                                              .itemListOfVariants)
                                      .value
                                      .toStringAsFixed(1)
                                      .toString() +
                                  "Php.")
                              : Text(controller
                                      .count_total_for_no_variants(index: index)
                                      .value
                                      .toStringAsFixed(1)
                                      .toString() +
                                  "Php."),
                          trailing: controller
                                      .finalItemsList[index].itemHasVariants ==
                                  1
                              ? Icon(Icons.arrow_forward_ios)
                              : SizedBox(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context)),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 6, context: context),
                      right: sizer.width(width: 6, context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Payment type: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 11, context: context)),
                      ),
                      Obx(
                        () => Text(
                          controller.order_payment_type.value,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  sizer.font(fontsize: 11, context: context)),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 6, context: context),
                      right: sizer.width(width: 6, context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 11, context: context)),
                      ),
                      Obx(
                        () => Text(
                          "₱ " +
                              controller
                                  .not_discounted_amount()
                                  .value
                                  .toStringAsFixed(1)
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  sizer.font(fontsize: 11, context: context)),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 6, context: context),
                      right: sizer.width(width: 6, context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Discount: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 11, context: context)),
                      ),
                      Obx(
                        () => Text(
                          controller.total_discount().value.toStringAsFixed(2),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  sizer.font(fontsize: 11, context: context)),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 6, context: context),
                      right: sizer.width(width: 6, context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discounted Amount: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 11, context: context)),
                      ),
                      Obx(
                        () => Text(
                          controller
                              .countotal_Amount_discounted()
                              .value
                              .toStringAsFixed(2)
                              .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  sizer.font(fontsize: 11, context: context)),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context)),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Obx(
                () => controller.order_payment_type.value != "Installment"
                    ? SizedBox()
                    : controller.isLoadingGettingInstallmentDetails.value ==
                            true
                        ? Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: sizer.font(fontsize: 10, context: context),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                      left: sizer.width(
                                          width: 6, context: context),
                                      right: sizer.width(
                                          width: 6, context: context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Days: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizer.font(
                                                fontsize: 11,
                                                context: context)),
                                      ),
                                      Obx(
                                        () => Text(
                                          controller
                                              .installment_Days_to_pay.value
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height:
                                    sizer.height(height: 2, context: context),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: sizer.width(
                                          width: 6, context: context),
                                      right: sizer.width(
                                          width: 6, context: context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Interest: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizer.font(
                                                fontsize: 11,
                                                context: context)),
                                      ),
                                      Obx(
                                        () => Text(
                                          controller.installment_percent_value
                                                  .toString() +
                                              "%",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height:
                                    sizer.height(height: 2, context: context),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: sizer.width(
                                          width: 6, context: context),
                                      right: sizer.width(
                                          width: 6, context: context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Amount per day: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizer.font(
                                                fontsize: 11,
                                                context: context)),
                                      ),
                                      Obx(
                                        () => Text(
                                          "₱ " +
                                              controller
                                                  .installment_amount_per_Day()
                                                  .value
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height:
                                    sizer.height(height: 2, context: context),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: sizer.width(
                                          width: 6, context: context),
                                      right: sizer.width(
                                          width: 6, context: context)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total installment amount: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizer.font(
                                                fontsize: 11,
                                                context: context)),
                                      ),
                                      Obx(
                                        () => Text(
                                          "₱ " +
                                              controller
                                                  .total_installment_amount()
                                                  .value
                                                  .toStringAsFixed(1)
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context)),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
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
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        // Get.to(() => SamplePrototype());
                        if (Get.find<BluetoothServices>().bluetoothState ==
                                12 ||
                            Get.find<BluetoothServices>().bluetoothState == 1) {
                          if (Get.find<BluetoothServices>().printerStatus ==
                              "Connected") {
                            print(controller.order_payment_type.value);
                            if (controller.order_payment_type.value ==
                                'Installment') {
                              controller.printReceipt_installment();
                            } else {
                              controller.printReceipt_cash_or_creditS(
                                  paymentype:
                                      controller.order_payment_type.value);
                            }
                          }
                        }
                      },
                      child: Text("Print",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                                  fontSize: sizer.font(
                                      fontsize: 10, context: context))
                              .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context)),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
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
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () async {
                        if (Get.find<ConnectivityService>()
                                .hasConnection
                                .value ==
                            true) {
                          controller.refundnow(context: context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Open Internet and Restart the app.'),
                          ));
                        }
                      },
                      child: Obx(
                        () => controller.isRefunding.value == true
                            ? Center(
                                child: SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: sizer.font(
                                      fontsize: 10, context: context),
                                ),
                              )
                            : Text("Refund",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                        fontSize: sizer.font(
                                            fontsize: 10, context: context))
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
