import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Items/Item_controller.dart';
import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';
// import 'package:mobilepos/helpers/storage.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
// import 'package:mobilepos/helpers/storage.dart';

class ItemUpdate extends GetView<ItemController> {
  const ItemUpdate({Key? key, this.itemID}) : super(key: key);
  final int? itemID;

  @override
  Widget build(BuildContext context) {
    final sizer = Sizer();
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
          "UPDATE ITEMS",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          padding: EdgeInsets.only(
              left: sizer.width(width: 5, context: context),
              top: sizer.height(height: 2, context: context),
              right: sizer.width(width: 5, context: context)),
          // color: Colors.pink,
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          // alignment: Alignment.center,
          child: Container(
            // color: Colors.green,
            child: Column(
              children: [
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: TextField(
                    controller: controller.itemName,
                    obscureText: false,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                // SizedBox(
                //   height: sizer.height(height: 2, context: context),
                // ),
                // Container(
                //   alignment: Alignment.center,
                //   // color: Colors.red,
                //   height: sizer.height(height: 6, context: context),
                //   width: sizer.width(width: 100, context: context),
                //   child: TextField(
                //     controller: controller.itemDescription,
                //     obscureText: false,
                //     style: TextStyle(
                //         fontSize: sizer.font(fontsize: 10, context: context)),
                //     decoration: InputDecoration(
                //         contentPadding:
                //             EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                //         hintText: "Description",
                //         border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(32.0))),
                //   ),
                // ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      // color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      )),
                  padding: EdgeInsets.only(
                      left: sizer.width(width: 5, context: context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: PopupMenuButton(
                          // icon: Icon(Icons.arrow_drop_down_outlined),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: sizer.height(height: 6, context: context),
                            width: sizer.width(width: 80, context: context),
                            // color: Colors.red,
                            child: Obx(() => Text(
                                  controller.dropdownvalue.value,
                                  style: TextStyle(
                                      color: controller.dropdownvalue.value ==
                                              'Select Category'
                                          ? Colors.grey[600]
                                          : Colors.black,
                                      fontSize: sizer.font(
                                          fontsize: 10, context: context)),
                                )),
                          ),
                          itemBuilder: (context) {
                            return List.generate(controller.categoryList.length,
                                (i) {
                              return PopupMenuItem(
                                onTap: () async {
                                  controller.dropdownvalue.value =
                                      controller.categoryList[i].categoryName;
                                  controller.itemCategoryid.value = controller
                                      .categoryList[i].categoryId
                                      .toString();
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: sizer.height(
                                          height: 2, context: context)),
                                  child: Container(
                                    width: sizer.width(
                                        width: 100, context: context),
                                    child: Text(controller
                                        .categoryList[i].categoryName),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: TextField(
                    controller: controller.itemCost,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Cost",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.red,
                      height: sizer.height(height: 6, context: context),
                      width: sizer.width(width: 65, context: context),
                      child: TextField(
                        controller: controller.itemBarcode,
                        obscureText: false,
                        onChanged: (value) {
                          controller.barcodeValue.value = value;
                        },
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 10, context: context)),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Barcode",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(
                          top: sizer.height(height: 0.5, context: context),
                          bottom: sizer.height(height: 0.5, context: context)),
                      height: sizer.height(height: 5, context: context),
                      width: sizer.width(width: 20, context: context),
                      alignment: Alignment.center,
                      child: Obx(
                        () => controller.barcodeValue.value.isNotEmpty
                            ? SfBarcodeGenerator(
                                textAlign: TextAlign.center,
                                value: controller.barcodeValue.value,
                                showValue: false,
                              )
                            : Container(),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Obx(
                  () => controller.variantListToUpdate.length == 0
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  // color: Colors.red,
                                  height:
                                      sizer.height(height: 6, context: context),
                                  width:
                                      sizer.width(width: 65, context: context),
                                  child: TextField(
                                    controller: controller.itemDiscount,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        fontSize: sizer.font(
                                            fontsize: 10, context: context)),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Discount",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(32.0))),
                                  ),
                                ),
                                Container(
                                  width:
                                      sizer.width(width: 20, context: context),
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: Colors.red,
                                    child: MaterialButton(
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      onPressed: () {
                                        if (controller.itemDiscountType.value ==
                                            "Amount") {
                                          controller.itemDiscountType.value =
                                              "Percent";
                                        } else {
                                          controller.itemDiscountType.value =
                                              "Amount";
                                        }
                                      },
                                      child: Obx(
                                        () => Text(
                                            controller.itemDiscountType.value ==
                                                    "Amount"
                                                ? "Amount"
                                                : "Percent",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                    fontSize: sizer.font(
                                                        fontsize: 10,
                                                        context: context))
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: sizer.height(height: 2, context: context),
                            ),
                            Container(
                              alignment: Alignment.center,
                              // color: Colors.red,
                              height: sizer.height(height: 6, context: context),
                              width: sizer.width(width: 100, context: context),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: controller.itemPrice,
                                obscureText: false,
                                style: TextStyle(
                                    fontSize: sizer.font(
                                        fontsize: 10, context: context)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Price",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                              ),
                            ),
                            SizedBox(
                              height: sizer.height(height: 2, context: context),
                            ),
                            Container(
                              alignment: Alignment.center,
                              // color: Colors.red,
                              height: sizer.height(height: 6, context: context),
                              width: sizer.width(width: 100, context: context),
                              child: TextField(
                                controller: controller.itemCount,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    fontSize: sizer.font(
                                        fontsize: 10, context: context)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    hintText: "Counts",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0))),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  child: Obx(
                    () => controller.variantListToUpdate.length == 0
                        ? Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(30.0),
                            // color: Color(0xff01A0C7),
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
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () {
                                  controller.showGetDialog_for_Adding_Variant(
                                      context: context,
                                      itemID: itemID.toString());
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                        width: sizer.width(
                                            width: 2, context: context)),
                                    Obx(
                                      () => Text(
                                          controller.variantListToUpdate
                                                      .length ==
                                                  0
                                              ? "Add Variant"
                                              : "Add More Variant",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                                  fontSize: sizer.font(
                                                      fontsize: 10,
                                                      context: context))
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                // color: Colors.red,
                                width:
                                    sizer.width(width: 100, context: context),
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: Wrap(
                                    children: List.generate(
                                        controller.variantListToUpdate.length,
                                        (index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: sizer.width(
                                                width: 1.5, context: context)),
                                        child: Chip(
                                          // labelPadding: EdgeInsets.all(2.0),
                                          // avatar: Icon(Icons.cancel),
                                          deleteIcon: Container(
                                              child: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          )),
                                          onDeleted: () {
                                            // controller.variantListToUpdate
                                            //     .removeAt(index);
                                            controller.delete_variants_inupdate(
                                                itemid: controller
                                                    .variantListToUpdate[index]
                                                    .variantMainitemId
                                                    .toString(),
                                                variantId: controller
                                                    .variantListToUpdate[index]
                                                    .variantId
                                                    .toString());
                                          },
                                          label: Text(
                                            controller
                                                    .variantListToUpdate[index]
                                                    .variantName +
                                                " " +
                                                "(₱ " +
                                                controller
                                                    .variantListToUpdate[index]
                                                    .variantPrice +
                                                " - " +
                                                controller
                                                    .variantListToUpdate[index]
                                                    .variantCount +
                                                "Pcs." +
                                                ")",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          backgroundColor: Colors.grey[300],
                                          elevation: 6.0,
                                          shadowColor: Colors.grey[60],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    sizer.height(height: 2, context: context),
                              ),
                              Material(
                                elevation: 5.0,
                                borderRadius: BorderRadius.circular(30.0),
                                // color: Color(0xff01A0C7),
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
                                    padding: EdgeInsets.fromLTRB(
                                        20.0, 15.0, 20.0, 15.0),
                                    onPressed: () {
                                      controller
                                          .showGetDialog_for_Adding_Variant(
                                              context: context,
                                              itemID: itemID.toString());
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                            width: sizer.width(
                                                width: 2, context: context)),
                                        Obx(
                                          () => Text(
                                              controller.variantListToUpdate
                                                          .length ==
                                                      0
                                                  ? "Add Variant"
                                                  : "Add More Variant",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                      fontSize: sizer.font(
                                                          fontsize: 10,
                                                          context: context))
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  height: sizer.height(height: 10, context: context),
                  width: sizer.width(width: 100, context: context),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Obx(
                    () => controller.selectedImage.value == ""
                        ? IconButton(
                            onPressed: () async {
                              controller.selectedImage.value =
                                  await controller.getImage_autoUpdate(
                                      itemid: itemID.toString(),
                                      item_store_id: Get.find<StorageService>()
                                          .box
                                          .read('storeid'));
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey,
                            ))
                        : controller.hasUpdated.value == false
                            ? controller.isLoadingUpdatingImage.value == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      controller.selectedImage.value =
                                          await controller.getImage_autoUpdate(
                                              itemid: itemID.toString(),
                                              item_store_id:
                                                  Get.find<StorageService>()
                                                      .box
                                                      .read('storeid'));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "$image_Endpoint/${controller.selectedImage.value}")),
                                      ),
                                    ),
                                  )
                            : controller.isLoadingUpdatingImage.value == true
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      controller.selectedImage.value =
                                          await controller.getImage_autoUpdate(
                                              itemid: itemID.toString(),
                                              item_store_id:
                                                  Get.find<StorageService>()
                                                      .box
                                                      .read('storeid'));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                            base64Decode(
                                                controller.selectedImage.value),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: sizer.width(width: 45, context: context),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () async {
                              controller.update_item(itemid: itemID.toString());
                            },
                            child: Text("UPDATE",
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
                      Container(
                        width: sizer.width(width: 42, context: context),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.red,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              controller.selectedImage = ''.obs;
                              // Get.find<StorageService>().removeData();
                              Get.back();
                            },
                            child: Text("CANCEL",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
