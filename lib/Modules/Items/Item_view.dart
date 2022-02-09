import 'package:get/get.dart';
import 'package:flutter/material.dart';
// import 'package:mobilepos/Modules/Homepage/homepage_controller.dart';
import 'package:mobilepos/Modules/Items/item_form_view.dart';
import 'package:mobilepos/Modules/Items/item_update.dart';
import 'package:mobilepos/helpers/sizer.dart';
// import 'package:mobilepos/helpers/storage.dart';

import 'Item_controller.dart';

class ItemView extends GetView<ItemController> {
  const ItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizer = Sizer();
    Get.put(ItemController());
    return WillPopScope(
      onWillPop: () => controller.getBackWillPop(),
      child: Obx(
        () => Scaffold(
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
              "ITEMS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: sizer.font(fontsize: 20, context: context)),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                controller.getBackWillPop();
              },
            ),
            actions: [
              // Icon(Icons.more_vert),
              // SizedBox(
              //   width: sizer.width(width: 2, context: context),
              // )
              PopupMenuButton(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          child: GestureDetector(
                            onTap: () {
                              if (controller.isSelect.value == false) {
                                controller.isSelect.value = true;
                                Get.back();
                              } else {
                                controller.isSelect.value = false;
                                Get.back();
                              }
                            },
                            child: Container(
                              height: sizer.height(height: 5, context: context),
                              // color: Colors.red,
                              child: Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: Colors.blue,
                                      size: sizer.font(
                                          fontsize: 10, context: context)),
                                  SizedBox(
                                    width:
                                        sizer.width(width: 2, context: context),
                                  ),
                                  Text("Select"),
                                ],
                              ),
                            ),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: GestureDetector(
                            onTap: () {
                              if (controller.isSelect.value == false) {
                                controller.isSelect.value = true;
                                // controller.selectAll();
                                Get.back();
                              } else {
                                controller.isSelect.value = false;
                                // controller.unSelectAll();
                                Get.back();
                              }
                            },
                            child: Container(
                              height: sizer.height(height: 5, context: context),
                              child: Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: Colors.blue,
                                      size: sizer.font(
                                          fontsize: 10, context: context)),
                                  SizedBox(
                                    width:
                                        sizer.width(width: 2, context: context),
                                  ),
                                  Text("Select All"),
                                ],
                              ),
                            ),
                          ),
                          value: 2,
                        )
                      ])
            ],
          ),
          body: Obx(
            () => Container(
              color: Colors.grey[200],
              height: sizer.height(height: 100, context: context),
              width: sizer.width(width: 100, context: context),
              alignment: Alignment.center,
              child: controller.isLoadingData.value == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.itemsList.isEmpty
                      ? Text("No items for now.")
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: controller.itemsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      // color: Colors.white,
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
                                                    width: 2,
                                                    context: context)),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Obx(
                                                      () => controller.isSelect
                                                                  .value ==
                                                              true
                                                          ? Checkbox(
                                                              checkColor:
                                                                  Colors.white,
                                                              activeColor: controller
                                                                          .itemsList[
                                                                              index]
                                                                          .itemBool
                                                                          .value ==
                                                                      false
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .lightBlue,
                                                              value: controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemBool
                                                                  .value,
                                                              onChanged:
                                                                  (value) {
                                                                if (controller
                                                                        .itemsList[
                                                                            index]
                                                                        .itemBool
                                                                        .value ==
                                                                    true) {
                                                                  controller
                                                                      .itemsList[
                                                                          index]
                                                                      .itemBool
                                                                      .value = false;
                                                                } else {
                                                                  controller
                                                                      .itemsList[
                                                                          index]
                                                                      .itemBool
                                                                      .value = true;
                                                                }
                                                              },
                                                            )
                                                          : SizedBox(),
                                                    ),
                                                    SizedBox(
                                                      width: sizer.width(
                                                          width: 2,
                                                          context: context),
                                                    ),
                                                    Container(
                                                      height: sizer.height(
                                                          height: 5,
                                                          context: context),
                                                      alignment:
                                                          Alignment.center,
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
                                                                  .itemsList[
                                                                      index]
                                                                  .itemName,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontSize: sizer.font(
                                                                      fontsize:
                                                                          11,
                                                                      context:
                                                                          context)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        color: Colors.red,
                                                        onPressed: () {
                                                          controller.deleteitems(
                                                              itemid: controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemId);
                                                        },
                                                        icon:
                                                            Icon(Icons.delete),
                                                      ),
                                                      IconButton(
                                                        color: Colors.blue,
                                                        onPressed: () async {
                                                          controller.hasUpdated
                                                              .value = false;
                                                          controller
                                                                  .selectedImage
                                                                  .value =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .item_Image
                                                                  .toString();
                                                          controller
                                                                  .dropdownvalue
                                                                  .value =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .item_category_name;
                                                          controller.itemName
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemName;
                                                          controller
                                                                  .itemDiscount
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .item_discount;
                                                          controller
                                                                  .itemDiscountType
                                                                  .value =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .item_discount_type;
                                                          controller.itemCost
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemCost;

                                                          controller
                                                                  .itemCategory
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemCategoryId
                                                                  .toString();
                                                          controller.itemCount
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemCount;
                                                          controller.itemBarcode
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemBarcode;
                                                          controller.itemPrice
                                                                  .text =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemPrice;
                                                          controller
                                                                  .barcodeValue
                                                                  .value =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemBarcode;
                                                          controller.hasVariant
                                                                  .value =
                                                              controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemHasVariants;
                                                          await controller.get_Variants(
                                                              itemid: controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemId
                                                                  .toString());
                                                          Get.to(() => ItemUpdate(
                                                              itemID: controller
                                                                  .itemsList[
                                                                      index]
                                                                  .itemId));
                                                        },
                                                        icon: Icon(Icons.edit),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: sizer.height(
                                                height: 1, context: context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
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
                                          left: sizer.width(
                                              width: 3, context: context),
                                          right: sizer.width(
                                              width: 3, context: context)),
                                      child: Material(
                                        elevation: 5.0,
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.lightBlue,
                                        child: MaterialButton(
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            onPressed: () {
                                              // controller.deleteSelectedItem();
                                            },
                                            child: Icon(Icons.delete_sharp)),
                                      ),
                                    ),
                            ),
                            controller.isSelect.value == true
                                ? Container()
                                : Container(
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80.0)),
                                        ),
                                        child: MaterialButton(
                                          // color:
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          onPressed: () {
                                            if (controller
                                                .categoryList.isEmpty) {
                                              controller
                                                  .showDialogEmptyCategory();
                                            } else {
                                              controller.itemName.clear();
                                              controller.itemDescription
                                                  .clear();
                                              controller.itemCategory.clear();
                                              controller.itemPrice.clear();
                                              controller.selectedImage.value =
                                                  "";
                                              controller.variantList.clear();
                                              controller.filename.value = '';
                                              controller.dropdownvalue.value =
                                                  'Select Category';
                                              controller.clearTextField();
                                              Get.to(() => ItemFormView());
                                            }
                                          },
                                          child: Text("ADD ITEM",
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
                            SizedBox(
                              height: sizer.height(height: 1, context: context),
                            ),
                          ],
                        ),
            ),
          ),
          // floatingActionButton: controller.isSelect.value == true
          //     ? null
          //     : FloatingActionButton(
          //         onPressed: () {
          //           if (controller.categoryList.isEmpty) {
          //             controller.showDialogEmptyCategory();
          //           } else {
          //             controller.itemName.clear();
          //             controller.itemDescription.clear();
          //             controller.itemCategory.clear();
          //             controller.itemPrice.clear();
          //             controller.selectedImage.value = "";
          //             controller.variantList.clear();
          //             controller.filename.value = '';
          //             controller.dropdownvalue.value = 'Select Category';
          //             controller.clearTextField();
          //             Get.to(() => ItemFormView());
          //           }
          //         },
          //         child: Container(
          //           height: sizer.height(height: 40, context: context),
          //           width: sizer.width(width: 40, context: context),
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             gradient: LinearGradient(
          //                 begin: Alignment.bottomLeft,
          //                 end: Alignment.topRight,
          //                 colors: [
          //                   Colors.cyanAccent,
          //                   Colors.greenAccent,
          //                   Colors.lightBlue,
          //                   Colors.tealAccent
          //                 ]),
          //           ),
          //           child: Icon(Icons.add),
          //         ),
          //       ),
        ),
      ),
    );
  }
}
