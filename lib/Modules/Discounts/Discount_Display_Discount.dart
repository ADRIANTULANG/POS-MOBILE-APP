import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Discounts/Discount_controller.dart';
import 'package:mobilepos/Modules/Discounts/Discount_Create.dart';
import 'package:mobilepos/Modules/Discounts/Discount_update.dart';
import 'package:mobilepos/helpers/DiscountServices.dart';
import 'package:mobilepos/helpers/sizer.dart';

class DiscountListView extends GetView<DiscountController> {
  const DiscountListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DiscountController());
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
            "DISCOUNTS",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizer.font(fontsize: 20, context: context)),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            SizedBox(
              width: sizer.width(width: 3, context: context),
            )
          ],

          // leading: Icon(Icons.),
        ),
        body: Container(
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          color: Colors.grey[200],
          padding: EdgeInsets.only(
              left: sizer.width(width: 2, context: context),
              right: sizer.width(width: 2, context: context)),
          child: Column(
            children: [
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: Get.find<DiscountServices>().discountList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ListTile(
                            // leading: Obx(
                            //   () => Switch(
                            //       onChanged: (value) {
                            //         if (Get.find<DiscountServices>()
                            //                 .discountList[index]
                            //                 .discountActive
                            //                 .value ==
                            //             false) {
                            //           Get.find<DiscountServices>()
                            //               .discountList[index]
                            //               .discountActive
                            //               .value = true;
                            //         } else {
                            //           Get.find<DiscountServices>()
                            //               .discountList[index]
                            //               .discountActive
                            //               .value = false;
                            //         }
                            //         if (Get.find<DiscountServices>()
                            //                 .discountid
                            //                 .value ==
                            //             Get.find<DiscountServices>()
                            //                 .discountList[index]
                            //                 .discountId) {
                            //           controller.resetAll();
                            //         } else {
                            //           controller.setActiveAndInActive(
                            //               discountID:
                            //                   Get.find<DiscountServices>()
                            //                       .discountList[index]
                            //                       .discountId);
                            //         }
                            //         print(Get.find<DiscountServices>()
                            //             .discountList[index]
                            //             .discountName);
                            //         print(Get.find<DiscountServices>()
                            //             .discountValue);
                            //         print(Get.find<DiscountServices>()
                            //             .discountType);
                            //         print(Get.find<DiscountServices>()
                            //             .discountid);
                            //       },
                            //       value: Get.find<DiscountServices>()
                            //           .discountList[index]
                            //           .discountActive
                            //           .value,
                            //       activeColor: Colors.blue,
                            //       activeTrackColor: Colors.grey[350],
                            //       inactiveThumbColor: Colors.grey,
                            //       inactiveTrackColor: Colors.grey[350]),
                            // ),
                            title: Text(Get.find<DiscountServices>()
                                .discountList[index]
                                .discountName),
                            subtitle: Obx(
                              () => Text(Get.find<DiscountServices>()
                                          .discountList[index]
                                          .discountType
                                          .value ==
                                      "Amount"
                                  ? "₱ " +
                                      Get.find<DiscountServices>()
                                          .discountList[index]
                                          .discount
                                  : Get.find<DiscountServices>()
                                          .discountList[index]
                                          .discount +
                                      " %"),
                            ),
                            trailing: Container(
                              width: sizer.width(width: 24, context: context),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.delete_Discount(
                                            context: context,
                                            discountid:
                                                Get.find<DiscountServices>()
                                                    .discountList[index]
                                                    .discountId);
                                      },
                                      icon: Icon(Icons.delete)),
                                  IconButton(
                                      onPressed: () {
                                        controller.discountName.text =
                                            Get.find<DiscountServices>()
                                                .discountList[index]
                                                .discountName;
                                        controller.discountValue.text =
                                            Get.find<DiscountServices>()
                                                .discountList[index]
                                                .discount;
                                        controller.discounttypevalue.value =
                                            Get.find<DiscountServices>()
                                                .discountList[index]
                                                .discountType
                                                .value;
                                        Get.to(() => DiscountUpdate(
                                              discountid:
                                                  Get.find<DiscountServices>()
                                                      .discountList[index]
                                                      .discountId
                                                      .toString(),
                                            ));
                                      },
                                      icon: Icon(Icons.edit)),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: sizer.height(height: 10, context: context),
                width: sizer.width(width: 100, context: context),
                // color: Colors.red,
                alignment: Alignment.center,
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

                      onPressed: () {
                        Get.to(() => DiscountView());
                      },
                      child: Text("Create Discount",
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
              )
            ],
          ),
        ));
  }
}
