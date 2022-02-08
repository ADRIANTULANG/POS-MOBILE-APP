import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Model/CartModel.dart';
import 'package:mobilepos/Modules/Homepage/Homepage_api.dart';
import 'package:mobilepos/Modules/Homepage/Homepage_model.dart';
import 'package:mobilepos/Modules/Login/login_view.dart';
import 'package:mobilepos/helpers/CartServices.dart';
import 'package:mobilepos/helpers/connectivity.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';
// import 'package:sqflite/sqflite.dart';

class HomepageController extends GetxController {
  @override
  void onInit() async {
    // await Get.find<StorageService>().getAllData();
    if (Get.find<ConnectivityService>().hasConnection.value == true) {
      get_items();
    } else {
      get_items_offline_mode();
    }
    super.onInit();
  }

  var sizer = Sizer();

  RxBool isGridView = true.obs;
  RxBool isSwitched = false.obs;
  RxString view = 'Grid View'.obs;

  RxBool showSearchField = false.obs;
  TextEditingController searchField = TextEditingController();

  RxBool isLoadingItems = true.obs;

  RxList<FinalItemsList> itemsList = <FinalItemsList>[].obs;
  RxList<FinalItemsList> itemsList_Master = <FinalItemsList>[].obs;
  RxList<ItemsModel> temporaryList = <ItemsModel>[].obs;
  RxList<ItemsModel> temporaryList_master = <ItemsModel>[].obs;

  get_items() async {
    var result = await HomepageApi.get_all_items();
    temporaryList_master.assignAll(result);
    temporaryList.assignAll(result);

    final stores = temporaryList.map((e) => e.itemId).toSet();
    temporaryList.retainWhere((x) => stores.remove(x.itemId));

    var tempItemListMainItemList = [];
    for (var i = 0; i < temporaryList.length; i++) {
      Map map = {
        "item_id": temporaryList[i].itemId,
        "item_name": temporaryList[i].itemName,
        "item_category_id": temporaryList[i].itemCategoryId,
        "item_cost": temporaryList[i].itemCost,
        "item_barcode": temporaryList[i].itemBarcode,
        "item_price": temporaryList[i].itemPrice,
        "item_count": temporaryList[i].itemCount,
        "item_has_variants": temporaryList[i].itemHasVariants,
        "item_store_id": temporaryList[i].itemStoreId,
        "item_Image": temporaryList[i].itemImage,
        "item_category_name": temporaryList[i].itemCategoryName,
        "item_Discount": temporaryList[i].itemDiscount,
        "item_Discount_type": temporaryList[i].itemDiscount_type,
        "itemQuantity": 0,
        "item_list_of_variants": []
      };
      tempItemListMainItemList.add(map);
    }

    for (var i = 0; i < tempItemListMainItemList.length; i++) {
      for (var z = 0; z < temporaryList_master.length; z++) {
        if (tempItemListMainItemList[i]['item_id'] ==
            temporaryList_master[z].itemId) {
          Map variantMap = {
            "variantQuantity": 0,
            "variant_id": temporaryList_master[z].variantId,
            "variant_name": temporaryList_master[z].variantName,
            "variant_count": temporaryList_master[z].variantCount,
            "variant_price": temporaryList_master[z].variantPrice,
            "variant_mainitem_id": temporaryList_master[z].variantMainitemId,
            "variant_store_id": temporaryList_master[z].variantStoreId,
            "variant_discount": temporaryList_master[z].variant_discount,
            "variant_discount_type":
                temporaryList_master[z].variant_discount_type,
          };
          tempItemListMainItemList[i]['item_list_of_variants'].add(variantMap);
        }
      }
    }
    Get.find<StorageService>()
        .setOfflineItems(listofitems: tempItemListMainItemList);
    var res = finalItemsListFromJson(jsonEncode(tempItemListMainItemList));

    itemsList.assignAll(res);
    itemsList_Master.assignAll(res);
    isLoadingItems.value = false;
  }

  get_items_offline_mode() {
    print(Get.find<StorageService>().box.read('listofitems'));
    var res;
    if (Get.find<StorageService>().box.read('listofitems') != null) {
      res = finalItemsListFromJson(
          jsonEncode(Get.find<StorageService>().box.read('listofitems')));
    } else {
      res = <FinalItemsList>[].obs;
    }
    itemsList.assignAll(res);
    itemsList_Master.assignAll(res);
    isLoadingItems.value = false;
  }

  add_quantity_no_variants({required int mainItemID}) {
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemId == mainItemID) {
        print("not masterList");
        itemsList[i].itemQuantity++;
        print(itemsList[i].itemName);
        print(itemsList[i].itemQuantity);
      }
    }
  }

  type_quantity_no_Variants(
      {required int mainItemID, required String quantity}) {
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemId == mainItemID) {
        itemsList[i].itemQuantity.value = int.parse(quantity);
      }
    }
  }

  add_quantity_variant({required int variantId, required int mainItemID}) {
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemId == mainItemID) {
        for (var z = 0; z < itemsList[i].itemListOfVariants.length; z++) {
          if (variantId == itemsList[i].itemListOfVariants[z].variantId) {
            itemsList[i].itemListOfVariants[z].variantQuantity.value++;
            itemsList[i].itemQuantity++;
          }
        }
      }
    }
  }

  type_quantity_has_variants(
      {required int variantId,
      required int mainItemID,
      required int quantity}) {
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemId == mainItemID) {
        for (var z = 0; z < itemsList[i].itemListOfVariants.length; z++) {
          if (variantId == itemsList[i].itemListOfVariants[z].variantId) {
            itemsList[i].itemQuantity.value = itemsList[i].itemQuantity.value -
                itemsList[i].itemListOfVariants[z].variantQuantity.value;
            itemsList[i].itemListOfVariants[z].variantQuantity.value = quantity;
            itemsList[i].itemQuantity.value = itemsList[i].itemQuantity.value +
                itemsList[i].itemListOfVariants[z].variantQuantity.value;
          }
        }
      }
    }
  }

  remove_quantity_variant({required int variantId, required int mainItemID}) {
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemId == mainItemID) {
        for (var z = 0; z < itemsList[i].itemListOfVariants.length; z++) {
          if (variantId == itemsList[i].itemListOfVariants[z].variantId) {
            if (itemsList[i].itemListOfVariants[z].variantQuantity.value == 0) {
            } else {
              itemsList[i].itemListOfVariants[z].variantQuantity.value--;
              itemsList[i].itemQuantity--;
            }
          }
        }
      }
    }
  }

  searchFunctionNew({required String stringtosearch}) {
    itemsList.clear();
    itemsList.addAll(itemsList_Master
        .where((u) => (u.itemName
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase()) ||
            u.itemBarcode
                .toString()
                .toLowerCase()
                .contains(stringtosearch.toLowerCase())))
        .toList());
    if (stringtosearch.isEmpty) {
      itemsList.assignAll(itemsList_Master);
    }
  }

  showDialog({required BuildContext context, required String word}) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: sizer.height(height: 20, context: context),
        width: sizer.width(width: 40, context: context),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Text(
              "Message",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizer.font(fontsize: 15, context: context),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 3, context: context),
            ),
            Text(
              "Only $word can access this page. Thank you!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: sizer.font(fontsize: 11, context: context),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Container(
                child: Divider(
              color: Colors.black,
            )),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                // color: Colors.red,
                alignment: Alignment.center,
                width: sizer.width(width: 50, context: context),
                height: sizer.height(height: 5, context: context),
                child: Text(
                  "OK",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sizer.font(fontsize: 15, context: context),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  showDialogLogOut({
    required BuildContext context,
  }) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: sizer.height(height: 20, context: context),
        width: sizer.width(width: 40, context: context),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Text(
              "Message",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizer.font(fontsize: 15, context: context),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 3, context: context),
            ),
            Text(
              "Are you sure you want to log out?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: sizer.font(fontsize: 11, context: context),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Container(
                child: Divider(
              color: Colors.black,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    // color: Colors.red,
                    alignment: Alignment.center,

                    height: sizer.height(height: 5, context: context),
                    child: Text(
                      "No",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sizer.font(fontsize: 15, context: context),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.find<StorageService>().removeUsers();
                    Get.offAll(() => LoginView());
                    print(Get.find<StorageService>().box.read('users'));
                  },
                  child: Container(
                    // color: Colors.red,
                    alignment: Alignment.center,

                    height: sizer.height(height: 5, context: context),
                    child: Text(
                      "Yes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: sizer.font(fontsize: 15, context: context),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  showDialog_add_or_remove_quantity_hasVariants(
      {required int itemID,
      required BuildContext context,
      required List<ItemListOfVariant> variantList}) {
    TextEditingController textField = TextEditingController();

    Get.dialog(AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: sizer.height(height: 50, context: context),
        width: sizer.width(width: 70, context: context),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          // color: Colors.red,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            bottomRight: Radius.circular(32),
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Text(
              "PRODUCTS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizer.font(fontsize: 15, context: context),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Container(
                child: Divider(
              color: Colors.black,
            )),
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: variantList.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: sizer.height(height: 1, context: context),
                      ),
                      child: Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(
                            left: sizer.width(width: 2, context: context),
                            right: sizer.width(width: 2, context: context)),
                        height: sizer.height(height: 5, context: context),
                        width: sizer.width(width: 100, context: context),
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.blue,
                              height: sizer.height(height: 5, context: context),
                              width: sizer.width(width: 25, context: context),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    variantList[index].variantName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: sizer.font(
                                          fontsize: 11, context: context),
                                    ),
                                  ),
                                  Text(
                                    "₱ " + variantList[index].variantPrice,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.bold,
                                      fontSize: sizer.font(
                                          fontsize: 9, context: context),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: sizer.width(width: 1, context: context),
                            ),
                            Expanded(
                              child: Container(
                                // color: Colors.red,
                                height:
                                    sizer.height(height: 5, context: context),
                                child: Obx(
                                  () => variantList[index]
                                              .variantShowTextField
                                              .value ==
                                          false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  if (int.parse(
                                                          variantList[index]
                                                              .variantCount) ==
                                                      0) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Variant of stock'),
                                                    ));
                                                  } else {
                                                    if (variantList[index]
                                                            .variantQuantity
                                                            .value ==
                                                        double.parse(
                                                            variantList[index]
                                                                .variantCount)) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                            'Maximum count of variant reach'),
                                                      ));
                                                    } else {
                                                      add_quantity_variant(
                                                        mainItemID: itemID,
                                                        variantId:
                                                            variantList[index]
                                                                .variantId,
                                                      );
                                                    }
                                                  }
                                                },
                                                icon: Icon(Icons.add_circle)),
                                            Container(
                                              width: sizer.width(
                                                  width: 15, context: context),
                                              alignment: Alignment.center,
                                              child: Obx(() => Container(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        textField.clear();
                                                      },
                                                      child: Text(
                                                        variantList[index]
                                                            .variantQuantity
                                                            .value
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: sizer.font(
                                                                fontsize: 10,
                                                                context:
                                                                    context),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  )),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  remove_quantity_variant(
                                                    mainItemID: itemID,
                                                    variantId:
                                                        variantList[index]
                                                            .variantId,
                                                  );
                                                },
                                                icon: Icon(Icons.remove_circle))
                                          ],
                                        )
                                      : TextField(
                                          textAlign: TextAlign.center,
                                          controller: textField,
                                          style: TextStyle(
                                              fontSize: sizer.font(
                                                  fontsize: 10,
                                                  context: context)),
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: sizer.width(
                                                      width: 9,
                                                      context: context)),
                                              suffixIcon: GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(Icons.check)),
                                              hintText: "",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0))),
                                        ),
                                ),
                              ),
                            ),
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
            Container(
                child: Divider(
              height: 0,
              color: Colors.black,
            )),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  // color: Colors.red,
                  height: sizer.height(height: 8, context: context),
                  width: sizer.width(width: 100, context: context),
                  alignment: Alignment.center,
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 14, context: context),
                    ),
                  )),
            )
          ],
        ),
      ),
    ));
  }

  RxBool isLoadingAddingToCart = true.obs;
  add_to_cart() {
    var list = [];
    for (var i = 0; i < itemsList.length; i++) {
      if (itemsList[i].itemQuantity.value != 0) {
        Map map = {
          "item_id": itemsList[i].itemId,
          "item_name": itemsList[i].itemName,
          "item_category_id": itemsList[i].itemCategoryId,
          "item_Quantity": itemsList[i].itemQuantity.value,
          "item_cost": itemsList[i].itemCost,
          "item_barcode": itemsList[i].itemBarcode,
          "item_price": itemsList[i].itemPrice.value,
          "item_count": itemsList[i].itemCount,
          "item_has_variants": itemsList[i].itemHasVariants,
          "item_store_id": itemsList[i].itemStoreId,
          "item_Image": itemsList[i].itemImage,
          "item_category_name": itemsList[i].itemCategoryName,
          "item_Discount": itemsList[i].item_Discount,
          "item_discount_type": itemsList[i].item_Discount_type,
          "item_variant_list": []
        };

        if (itemsList[i].itemHasVariants == 1) {
          for (var z = 0; z < itemsList[i].itemListOfVariants.length; z++) {
            Map variantmap = {
              "variant_id": itemsList[i].itemListOfVariants[z].variantId,
              "variant_name": itemsList[i].itemListOfVariants[z].variantName,
              "variant_count": itemsList[i].itemListOfVariants[z].variantCount,
              "variant_price": itemsList[i].itemListOfVariants[z].variantPrice,
              "variant_mainitem_id":
                  itemsList[i].itemListOfVariants[z].variantMainitemId,
              "variant_store_id":
                  itemsList[i].itemListOfVariants[z].variantStoreId,
              "variant_Quantity":
                  itemsList[i].itemListOfVariants[z].variantQuantity.value,
              "variant_discount":
                  itemsList[i].itemListOfVariants[z].variant_discount,
              "variant_discount_type":
                  itemsList[i].itemListOfVariants[z].variant_discount_type,
            };
            map['item_variant_list'].add(variantmap);
          }
        }
        list.add(map);
      }
    }
    Get.find<CartServices>().cart.assignAll(cartListFromJson(jsonEncode(list)));
    isLoadingAddingToCart.value = false;
  }
}
