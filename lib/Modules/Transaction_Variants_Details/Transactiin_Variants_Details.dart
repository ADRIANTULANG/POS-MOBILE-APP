import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Transaction_Variants_Details/Transaction_Variants_Details_Controller.dart';
import 'package:mobilepos/helpers/sizer.dart';

class TransactionVariantsDetails
    extends GetView<TransactionVariantsDetailsController> {
  const TransactionVariantsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TransactionVariantsDetailsController());
    var sizer = Sizer();
    TextStyle style = TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        fontSize: sizer.font(fontsize: 9, context: context));
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
          "TRANSACTION VARIANT DETAILS",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 16, context: context)),
        ),
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        child: Obx(
          () => controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.variantList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return controller.variantList[index].variantQuantity == "0"
                        ? SizedBox()
                        : Container(
                            padding: EdgeInsets.only(
                                top: sizer.width(width: 2, context: context),
                                left: sizer.width(width: 5, context: context),
                                right: sizer.width(width: 5, context: context)),
                            height: sizer.height(height: 5, context: context),
                            width: sizer.width(width: 100, context: context),
                            alignment: Alignment.center,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height:
                                    sizer.height(height: 6, context: context),
                                width:
                                    sizer.width(width: 100, context: context),
                                // color: Colors.red,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "• " +
                                              controller.variantList[index]
                                                  .variantName
                                                  .toString()
                                                  .capitalizeFirst!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: sizer.font(
                                                  fontsize: 11,
                                                  context: context)),
                                        ),
                                        Container(
                                          width: sizer.width(
                                              width: 33, context: context),
                                          // color: Colors.green,
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                controller.variantList[index]
                                                    .variantQuantity,
                                                style: style,
                                              ),
                                              Text("  x  ", style: style),
                                              Text(
                                                  controller.variantList[index]
                                                      .variantPrice,
                                                  style: style),
                                              Text("  =  ", style: style),
                                              Text(
                                                  "₱ " +
                                                      (int.parse(controller
                                                                  .variantList[
                                                                      index]
                                                                  .variantQuantity) *
                                                              double.parse(controller
                                                                  .variantList[
                                                                      index]
                                                                  .variantPrice))
                                                          .toString(),
                                                  style: style),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: sizer.width(
                                          width: 100, context: context),
                                      child: Text(
                                        "Discount " +
                                            "(₱${controller.totaDiscountOfVariant(variantPrice: double.parse(controller.variantList[index].variantPrice), variantQuantity: int.parse(controller.variantList[index].variantQuantity.toString()))})",
                                        style: style,
                                      ),
                                    )
                                  ],
                                )),
                          );
                  },
                ),
        ),
      ),
    );
  }
}
