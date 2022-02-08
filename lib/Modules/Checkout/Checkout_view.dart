import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Checkout/Checkout_controller.dart';
import 'package:mobilepos/helpers/CartServices.dart';
import 'package:mobilepos/helpers/DiscountServices.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/connectivity.dart';

import 'package:mobilepos/helpers/sizer.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());
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
          "CHECKOUT",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: sizer.height(height: 90, context: context),
          width: sizer.width(width: 100, context: context),
          color: Colors.grey[200],
          child: Column(
            children: [
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Text("ITEMS OVERVIEW",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: sizer.font(fontsize: 15, context: context))),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                // height: sizer.height(height: 35, context: context),
                // width: sizer.width(width: 100, context: context),
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: Get.find<CartServices>().cart.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          alignment: Alignment.center,
                          // color: Colors.red,
                          padding: EdgeInsets.only(
                              left: sizer.width(width: 2, context: context),
                              right: sizer.width(width: 2, context: context)),
                          height: sizer.height(height: 5, context: context),
                          width: sizer.width(width: 100, context: context),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    sizer.height(height: 1, context: context),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                height:
                                    sizer.height(height: 4, context: context),
                                width:
                                    sizer.width(width: 100, context: context),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: sizer.width(
                                              width: 2, context: context),
                                        ),
                                        PopupMenuButton(
                                            child: Container(
                                              constraints: BoxConstraints(
                                                minWidth: sizer.width(
                                                    width: 6, context: context),
                                                maxWidth: sizer.width(
                                                    width: 10,
                                                    context: context),
                                              ),
                                              height: sizer.height(
                                                  height: 3, context: context),
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.only(
                                                  left: sizer.width(
                                                      width: 1,
                                                      context: context),
                                                  right: sizer.width(
                                                      width: 1,
                                                      context: context)),
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin:
                                                          Alignment.bottomLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Colors.cyanAccent,
                                                        Colors.greenAccent,
                                                        Colors.lightBlue,
                                                        Colors.tealAccent
                                                      ]),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Obx(
                                                () => Text(
                                                    Get.find<CartServices>()
                                                        .cart[index]
                                                        .item_Quantity
                                                        .value
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: sizer.font(
                                                            fontsize: 11,
                                                            context: context))),
                                              ),
                                            ),
                                            itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    child: Get.find<CartServices>()
                                                                .cart[index]
                                                                .itemVariantList!
                                                                .length ==
                                                            0
                                                        ? Container(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    width: sizer.width(
                                                                        width:
                                                                            17,
                                                                        context:
                                                                            context),
                                                                    child: Text(
                                                                        Get.find<CartServices>()
                                                                            .cart[
                                                                                index]
                                                                            .itemName
                                                                            .toString(),
                                                                        overflow:
                                                                            TextOverflow
                                                                                .ellipsis,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: sizer.font(fontsize: 11, context: context)))),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (Get.find<CartServices>()
                                                                              .cart[index]
                                                                              .item_Quantity
                                                                              .value ==
                                                                          0) {
                                                                      } else {
                                                                        controller.remove_quantity_no_variants(
                                                                            mainitemId:
                                                                                Get.find<CartServices>().cart[index].itemId);
                                                                      }
                                                                    },
                                                                    icon: Icon(Icons
                                                                        .remove)),
                                                                SizedBox(
                                                                  width: sizer.width(
                                                                      width: 1,
                                                                      context:
                                                                          context),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    controller
                                                                        .enterquantity
                                                                        .text = Get.find<
                                                                            CartServices>()
                                                                        .cart[
                                                                            index]
                                                                        .item_Quantity
                                                                        .value
                                                                        .toString();
                                                                    controller.showdialog_enter_quantity_no_variants(
                                                                        context:
                                                                            context,
                                                                        mainItemID: Get.find<CartServices>()
                                                                            .cart[index]
                                                                            .itemId);
                                                                  },
                                                                  child: Obx(
                                                                    () => Text(
                                                                        Get.find<CartServices>()
                                                                            .cart[
                                                                                index]
                                                                            .item_Quantity
                                                                            .value
                                                                            .toString(),
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: sizer.font(fontsize: 11, context: context))),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: sizer.width(
                                                                      width: 1,
                                                                      context:
                                                                          context),
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      if (Get.find<CartServices>()
                                                                              .cart[
                                                                                  index]
                                                                              .item_Quantity
                                                                              .value ==
                                                                          double.parse(Get.find<CartServices>()
                                                                              .cart[index]
                                                                              .itemCount)) {
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text('Maximum count of item reach'),
                                                                        ));
                                                                      } else {
                                                                        controller.add_quantity_no_variants(
                                                                            mainitemId:
                                                                                Get.find<CartServices>().cart[index].itemId);
                                                                      }
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .add)),
                                                              ],
                                                            ),
                                                          )
                                                        : Container(
                                                            width: sizer.width(
                                                                width: 60,
                                                                context:
                                                                    context),
                                                            child: ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              itemCount: Get.find<
                                                                      CartServices>()
                                                                  .cart[index]
                                                                  .itemVariantList!
                                                                  .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int variantIndex) {
                                                                return Container(
                                                                  height: sizer.height(
                                                                      height: 5,
                                                                      context:
                                                                          context),
                                                                  width: sizer.width(
                                                                      width: 50,
                                                                      context:
                                                                          context),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                              width: sizer.width(width: 17, context: context),
                                                                              child: Text(Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variantName.toString(), overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: sizer.font(fontsize: 11, context: context)))),
                                                                          SizedBox(
                                                                            width:
                                                                                sizer.width(width: 1, context: context),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          IconButton(
                                                                              onPressed: () async {
                                                                                if (0 == Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variant_Quantity.value) {
                                                                                } else {
                                                                                  controller.remove_quantity_has_variants(mainitemid: Get.find<CartServices>().cart[index].itemId, variantid: Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variantId);
                                                                                }
                                                                              },
                                                                              icon: Icon(Icons.remove)),
                                                                          SizedBox(
                                                                            width:
                                                                                sizer.width(width: 1, context: context),
                                                                          ),
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              controller.enterquantity.text = Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variant_Quantity.value.toString();
                                                                              controller.showdialog_enter_quantity_has_variants(context: context, mainItemID: Get.find<CartServices>().cart[index].itemId, variantid: Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variantId);
                                                                            },
                                                                            child:
                                                                                Obx(() => Text(Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variant_Quantity.value.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: sizer.font(fontsize: 11, context: context)))),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                sizer.width(width: 1, context: context),
                                                                          ),
                                                                          IconButton(
                                                                              onPressed: () {
                                                                                if (double.parse(Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variantCount) == Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variant_Quantity.value) {
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                    content: Text('Maximum count of variant reach'),
                                                                                  ));
                                                                                } else {
                                                                                  controller.add_quantity_has_variants(mainitemid: Get.find<CartServices>().cart[index].itemId, variantid: Get.find<CartServices>().cart[index].itemVariantList![variantIndex].variantId);
                                                                                }
                                                                              },
                                                                              icon: Icon(Icons.add)),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                    value: 1,
                                                  ),
                                                ]),
                                        SizedBox(
                                          width: sizer.width(
                                              width: 2, context: context),
                                        ),
                                        Container(
                                          child: Text(
                                            Get.find<CartServices>()
                                                .cart[index]
                                                .itemName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: sizer.font(
                                                    fontsize: 11,
                                                    context: context)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: sizer.width(
                                              width: 2, context: context),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<CartServices>()
                                            .cart[index]
                                            .itemVariantList!
                                            .isNotEmpty) {
                                        } else {}
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            // color: Colors.red,
                                            height: sizer.height(
                                                height: 4, context: context),
                                            width: sizer.width(
                                                width: 12, context: context),
                                            child: Get.find<CartServices>()
                                                        .cart[index]
                                                        .itemHasVariants ==
                                                    1
                                                ? Obx(
                                                    () => Text(
                                                      controller
                                                          .count_total_amount_perItem_has_variants_With_no_Discount(
                                                              listofvariants: Get
                                                                      .find<
                                                                          CartServices>()
                                                                  .cart[index]
                                                                  .itemVariantList!)
                                                          .value
                                                          .toStringAsFixed(2)
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: sizer.font(
                                                              fontsize: 9,
                                                              context:
                                                                  context)),
                                                    ),
                                                  )
                                                : Obx(
                                                    () => Text(
                                                      controller
                                                          .count_total_amount_perItem_no_variants_with_no_Discount(
                                                              discounttype: Get.find<
                                                                      CartServices>()
                                                                  .cart[index]
                                                                  .item_discount_type,
                                                              discount: double.parse(Get.find<
                                                                      CartServices>()
                                                                  .cart[index]
                                                                  .item_Discount),
                                                              itemprice: double
                                                                  .parse(Get.find<
                                                                          CartServices>()
                                                                      .cart[
                                                                          index]
                                                                      .itemPrice),
                                                              quantity: Get.find<
                                                                      CartServices>()
                                                                  .cart[index]
                                                                  .item_Quantity
                                                                  .value)
                                                          .value
                                                          .toStringAsFixed(2)
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: sizer.font(
                                                              fontsize: 9,
                                                              context:
                                                                  context)),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Divider(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: sizer.height(height: 4, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: sizer.width(width: 3, context: context)),
                            Obx(
                              () => Text(
                                controller.total_Discount().value == 0.0
                                    ? "TOTAL PRICE:"
                                    : "TOTAL:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizer.font(
                                        fontsize: 11, context: context)),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                "₱ " +
                                    controller
                                        .countotal_Amount_with_no_Discount(
                                            cart: Get.find<CartServices>().cart)
                                        .value
                                        .toStringAsFixed(2)
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizer.font(
                                        fontsize: 11, context: context)),
                              ),
                            ),
                            SizedBox(
                              width: sizer.width(width: 7.5, context: context),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Obx(
                () => controller.total_Discount().value == 0.0
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.only(
                            left: sizer.width(width: 2, context: context),
                            right: sizer.width(width: 2, context: context)),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: sizer.height(height: 4, context: context),
                            width: sizer.width(width: 100, context: context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: sizer.width(
                                            width: 3, context: context)),
                                    Text(
                                      "TOTAL DISCOUNT:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: sizer.font(
                                              fontsize: 11, context: context)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => Text(
                                        "₱ " +
                                            controller
                                                .total_Discount()
                                                .value
                                                .toStringAsFixed(2)
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizer.font(
                                                fontsize: 11,
                                                context: context)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: sizer.width(
                                          width: 7.5, context: context),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Obx(
                () => controller.total_Discount().value == 0.0
                    ? SizedBox()
                    : Container(
                        padding: EdgeInsets.only(
                            left: sizer.width(width: 2, context: context),
                            right: sizer.width(width: 2, context: context)),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: sizer.height(height: 4, context: context),
                            width: sizer.width(width: 100, context: context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: sizer.width(
                                            width: 3, context: context)),
                                    Text(
                                      "FINAL PRICE:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: sizer.font(
                                              fontsize: 11, context: context)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Obx(
                                      () => Text(
                                        "₱ " +
                                            controller
                                                .countotal_Amount(
                                                    cart:
                                                        Get.find<CartServices>()
                                                            .cart)
                                                .value
                                                .toStringAsFixed(2)
                                                .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: sizer.font(
                                                fontsize: 11,
                                                context: context)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: sizer.width(
                                          width: 7.5, context: context),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: sizer.width(width: 5, context: context),
                    ),
                    child: Text(
                      "Cash Received:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 11, context: context)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: sizer.width(width: 2, context: context),
                          right: sizer.width(width: 2, context: context)),
                      alignment: Alignment.center,
                      // color: Colors.red,
                      height: sizer.height(height: 4, context: context),

                      child: TextField(
                        onChanged: (text) {
                          print("text: $text");
                          if (text == "") {
                            controller.change.value = 0.0;
                          } else {
                            controller.calculate_change(
                                amount: double.parse(text));
                          }
                        },
                        controller: controller.amountReceived,
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 12, context: context)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: sizer.width(width: 3, context: context)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: sizer.width(width: 5, context: context),
                    ),
                    child: Text(
                      "Customer Name:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: sizer.font(fontsize: 11, context: context)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: sizer.width(width: 2, context: context),
                          right: sizer.width(width: 2, context: context)),
                      alignment: Alignment.center,
                      // color: Colors.red,
                      height: sizer.height(height: 4, context: context),

                      child: TextField(
                        controller: controller.customerName,
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 12, context: context)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: sizer.width(width: 3, context: context)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 2, context: context)),
                child: Container(
                    padding: EdgeInsets.only(
                      left: sizer.width(width: 3, context: context),
                    ),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: sizer.height(height: 4, context: context),
                    width: sizer.width(width: 100, context: context),
                    child: Obx(
                      () => Text(
                        "Change:  " +
                            controller.change.value
                                .toStringAsFixed(2)
                                .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 11, context: context)),
                      ),
                    )),
              ),
              SizedBox(
                height: sizer.height(height: 1, context: context),
              ),
              Container(
                height: sizer.height(height: 20, context: context),
                width: sizer.width(width: 100, context: context),
                child: Obx(
                  () => ListView.builder(
                    itemCount: Get.find<DiscountServices>().discountList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: ListTile(
                          leading: Obx(
                            () => Switch(
                                onChanged: (value) {
                                  if (Get.find<DiscountServices>()
                                          .discountList[index]
                                          .discountActive
                                          .value ==
                                      false) {
                                    Get.find<DiscountServices>()
                                        .discountList[index]
                                        .discountActive
                                        .value = true;
                                  } else {
                                    Get.find<DiscountServices>()
                                        .discountList[index]
                                        .discountActive
                                        .value = false;
                                  }
                                  if (Get.find<DiscountServices>()
                                          .discountid
                                          .value ==
                                      Get.find<DiscountServices>()
                                          .discountList[index]
                                          .discountId) {
                                    controller.resetAll();
                                  } else {
                                    controller.setActiveAndInActive(
                                        discountID: Get.find<DiscountServices>()
                                            .discountList[index]
                                            .discountId);
                                  }
                                  print(Get.find<DiscountServices>()
                                      .discountList[index]
                                      .discountName);
                                  print(Get.find<DiscountServices>()
                                      .discountValue);
                                  print(Get.find<DiscountServices>()
                                      .discountType);
                                  print(
                                      Get.find<DiscountServices>().discountid);
                                },
                                value: Get.find<DiscountServices>()
                                    .discountList[index]
                                    .discountActive
                                    .value,
                                activeColor: Colors.blue,
                                activeTrackColor: Colors.grey[350],
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.grey[350]),
                          ),
                          title: Text(Get.find<DiscountServices>()
                              .discountList[index]
                              .discountName),
                          subtitle: Obx(
                            () => Text(Get.find<DiscountServices>()
                                        .discountList[index]
                                        .discountType
                                        .value ==
                                    "Amount"
                                ? Get.find<DiscountServices>()
                                        .discountList[index]
                                        .discount +
                                    " Php."
                                : Get.find<DiscountServices>()
                                        .discountList[index]
                                        .discount +
                                    " %"),
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
                () => controller.isLoadingTransaction.value == true
                    ? Container(
                        child: Center(
                          child: SpinKitThreeBounce(
                            color: Colors.teal[300],
                            size: sizer.font(fontsize: 30, context: context),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: sizer.width(width: 2, context: context),
                                right: sizer.width(width: 2, context: context)),
                            width: sizer.width(width: 100, context: context),
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
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () async {
                                    if (Get.find<BluetoothServices>()
                                                .bluetoothState ==
                                            12 ||
                                        Get.find<BluetoothServices>()
                                                .bluetoothState ==
                                            1) {
                                      if (Get.find<BluetoothServices>()
                                              .printerStatus ==
                                          "Connected") {
                                        controller.printReceipt_cash_or_credit(
                                            paymentype: "Cash");
                                      }
                                    }

                                    if (Get.find<ConnectivityService>()
                                            .hasConnection
                                            .value ==
                                        true) {
                                      controller.create_order(
                                          context: context,
                                          paymenttype: "Cash");
                                    } else {
                                      controller
                                          .offline_transactions_save_to_local(
                                              paymenttype: "Cash",
                                              context: context);
                                    }
                                  },
                                  child: Text("CASH",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              fontSize: sizer.font(
                                                  fontsize: 10,
                                                  context: context))
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 1, context: context),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: sizer.width(width: 2, context: context),
                                right: sizer.width(width: 2, context: context)),
                            width: sizer.width(width: 100, context: context),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30.0),
                              // color: Colors.blue,
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomRight,
                                      end: Alignment.topLeft,
                                      colors: [
                                        Colors.greenAccent,
                                        Colors.cyanAccent,
                                        Colors.lightBlue,
                                        Colors.tealAccent,
                                        Colors.lightBlue,
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () async {
                                    if (Get.find<BluetoothServices>()
                                                .bluetoothState ==
                                            12 ||
                                        Get.find<BluetoothServices>()
                                                .bluetoothState ==
                                            1) {
                                      if (Get.find<BluetoothServices>()
                                              .printerStatus ==
                                          "Connected") {
                                        controller.printReceipt_cash_or_credit(
                                            paymentype: "Credit");
                                      }
                                    }
                                    if (Get.find<ConnectivityService>()
                                            .hasConnection
                                            .value ==
                                        true) {
                                      controller.create_order(
                                          context: context,
                                          paymenttype: "Credit");
                                    } else {
                                      controller
                                          .offline_transactions_save_to_local(
                                              paymenttype: "Credit",
                                              context: context);
                                    }
                                  },
                                  child: Text("CREDIT",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              fontSize: sizer.font(
                                                  fontsize: 10,
                                                  context: context))
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizer.height(height: 1, context: context),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: sizer.width(width: 2, context: context),
                                right: sizer.width(width: 2, context: context)),
                            width: sizer.width(width: 100, context: context),
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
                                        Colors.greenAccent,
                                        Colors.lightBlue,
                                        Colors.tealAccent
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(32.0)),
                                ),
                                child: MaterialButton(
                                  minWidth: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),
                                  onPressed: () async {
                                    if (Get.find<ConnectivityService>()
                                            .hasConnection
                                            .value ==
                                        true) {
                                      controller.installmentDialog(
                                          context: context, sizer: sizer);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'No Internet. Turn on internet and restart the app'),
                                      ));
                                    }
                                  },
                                  child: Text("INSTALLMENT",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                              fontSize: sizer.font(
                                                  fontsize: 10,
                                                  context: context))
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
