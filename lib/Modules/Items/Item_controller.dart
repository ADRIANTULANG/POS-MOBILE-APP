import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:mobilepos/Modules/Category/Category_model.dart';
import 'package:mobilepos/Modules/Category/Category_view.dart';
import 'package:mobilepos/Modules/Homepage/homepage_controller.dart';
import 'package:mobilepos/Modules/Items/item_api.dart';
import 'package:mobilepos/Modules/Items/item_model.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';

class ItemController extends GetxController {
  TextEditingController itemName = TextEditingController();
  TextEditingController itemCategory = TextEditingController();
  TextEditingController itemPrice = TextEditingController();
  TextEditingController itemDescription = TextEditingController();
  TextEditingController itemCount = TextEditingController();
  TextEditingController itemCost = TextEditingController();
  TextEditingController itemDiscount = TextEditingController();
  TextEditingController itemBarcode = TextEditingController();

  TextEditingController variantName = TextEditingController();
  TextEditingController variantPrice = TextEditingController();
  TextEditingController variantCount = TextEditingController();
  TextEditingController variantDiscount = TextEditingController();

  RxString itemDiscountType = "Amount".obs;
  RxString variantDiscountType = "Amount".obs;

  RxString selectedImage = ''.obs;

  RxBool isSelect = false.obs;

  RxString barcodeValue = ''.obs;

  RxString filename = "".obs;

  RxInt hasVariant = 0.obs;
  RxString itemIdToUpdate = "".obs;

  RxList<Categories> categoryList = <Categories>[].obs;
  RxList<ItemsNew> itemsList = <ItemsNew>[].obs;
  RxList<VariantListInUpdate> variantListToUpdate = <VariantListInUpdate>[].obs;

  RxString itemCategoryid = "0".obs;

  RxString dropdownvalue = 'Select Category'.obs;

  File? imagessss;

  RxBool isLoadingUpdatingImage = false.obs;

  RxBool hasUpdated = false.obs;

  RxBool isLoadingData = true.obs;
  final box = GetStorage();
  var sizer = Sizer();
  @override
  void onInit() {
    getAllItems();
    getAllCategory();

    super.onInit();
  }

  getAllCategory() async {
    var result = await itemApi.get_all_Categories(
        storeid: Get.find<StorageService>().box.read('storeid'));
    categoryList.assignAll(result);
  }

  getAllItems() async {
    var result = await itemApi.get_All_items(
        storeid: Get.find<StorageService>().box.read('storeid'));
    itemsList.assignAll(result);

    isLoadingData.value = false;
  }

  deleteitems({required int itemid}) async {
    var result = await itemApi.delete_items(itemid: itemid);
    getAllItems();
    print(result);
  }

  get_Variants({required String itemid}) async {
    var result = await itemApi.get_All_Variants(
      storeid: Get.find<StorageService>().box.read('storeid'),
      itemId: itemid,
    );
    // hasUpdated.value = false;
    variantListToUpdate.assignAll(result);
  }

  delete_variants_inupdate(
      {required String variantId, required String itemid}) async {
    var result = await itemApi.delete_variants(
        // storeid: Get.find<StorageService>().box.read('storeid'),
        variantID: variantId,
        itemid: itemid);
    print(result);
    var request = await itemApi.get_All_Variants(
      storeid: Get.find<StorageService>().box.read('storeid'),
      itemId: itemid,
    );

    variantListToUpdate.assignAll(request);
    getAllItems();
  }

  add_items() async {
    var result = await itemApi.add_items(
        filepath: imagessss!,
        item_category_name: dropdownvalue.value,
        item_image: filename.value,
        item_name: itemName.text,
        item_category_id: itemCategoryid.value,
        item_cost: itemCost.text,
        item_barcode: itemBarcode.text,
        item_discount_type: itemDiscountType.value,
        item_discount: itemDiscount.text.isEmpty ? "0" : itemDiscount.text,
        item_price: variantList.isEmpty ? itemPrice.text : "0",
        item_count: variantList.isEmpty ? itemCount.text : "0",
        item_has_variants: variantList.isEmpty ? 0.toString() : 1.toString(),
        item_store_id: Get.find<StorageService>().box.read("storeid"));
    print("last inserted id $result");
    var mainitemId = result;
    getAllItems();
    if (variantList.isNotEmpty) {
      for (var i = 0; i < variantList.length; i++) {
        var variantresult = await itemApi.addVariants(
            variant_discount: variantList[i]['variant_discount'],
            variant_discount_type: variantList[i]['variant_discount_type'],
            variant_name: variantList[i]['variant_name'],
            variant_count: variantList[i]['variant_count'],
            variant_price: variantList[i]['variant_price'],
            variant_mainitem_id: mainitemId.toString(),
            variant_store_id:
                Get.find<StorageService>().box.read('storeid').toString());
        print(variantresult);
      }
    }
    clearTextField();
    Get.back();
  }

  getBackreset() {
    selectedImage = ''.obs;
    filename.value = "";
    // Get.find<StorageService>().removeData();
    Get.back();
    print("reset");
  }

  add_items_no_image() async {
    var result = await itemApi.add_items_no_images(
        item_category_name: dropdownvalue.value,
        item_image: filename.value,
        item_name: itemName.text,
        item_category_id: itemCategoryid.value,
        item_cost: itemCost.text,
        item_barcode: itemBarcode.text,
        item_discount_type: itemDiscountType.value,
        item_discount: itemDiscount.text.isEmpty ? "0" : itemDiscount.text,
        item_price: variantList.isEmpty ? itemPrice.text : "0",
        item_count: variantList.isEmpty ? itemCount.text : "0",
        item_has_variants: variantList.isEmpty ? 0.toString() : 1.toString(),
        item_store_id: Get.find<StorageService>().box.read("storeid"));
    print("last inserted id $result");
    var mainitemId = result;
    getAllItems();
    if (variantList.isNotEmpty) {
      for (var i = 0; i < variantList.length; i++) {
        var variantresult = await itemApi.addVariants(
            variant_discount: variantList[i]['variant_discount'],
            variant_discount_type: variantList[i]['variant_discount_type'],
            variant_name: variantList[i]['variant_name'],
            variant_count: variantList[i]['variant_count'],
            variant_price: variantList[i]['variant_price'],
            variant_mainitem_id: mainitemId.toString(),
            variant_store_id:
                Get.find<StorageService>().box.read('storeid').toString());
        print(variantresult);
      }
    }
    clearTextField();
    Get.back();
  }

  update_item({required String itemid}) async {
    var result = await itemApi.update_items(
        // filepath: imagessss!,
        item_category_name: dropdownvalue.value,
        itemid: itemid,
        item_name: itemName.text,
        item_category_id: itemCategoryid.value,
        item_cost: itemCost.text,
        item_barcode: itemBarcode.text,
        item_discount: itemDiscount.text,
        item_discount_type: itemDiscountType.value,
        item_price: variantListToUpdate.isEmpty ? itemPrice.text : "0",
        item_count: variantListToUpdate.isEmpty ? itemCount.text : "0",
        item_has_variants:
            variantListToUpdate.isEmpty ? 0.toString() : 1.toString(),
        item_store_id: Get.find<StorageService>().box.read("storeid"));
    print(result);
    Get.back();
    getAllItems();
  }

  addVariants_Automatically({
    required String variant_name,
    required String variant_count,
    required String variant_price,
    required String mainitemId,
    required String variant_discount,
    required String variant_discount_type,
  }) async {
    print("varian Added");
    var variantresult = await itemApi.addVariants(
        variant_discount: variant_discount,
        variant_discount_type: variant_discount_type,
        variant_name: variant_name,
        variant_count: variant_count,
        variant_price: variant_price,
        variant_mainitem_id: mainitemId.toString(),
        variant_store_id:
            Get.find<StorageService>().box.read('storeid').toString());
    print(variantresult);
    var result = await itemApi.get_All_Variants(
      storeid: Get.find<StorageService>().box.read('storeid'),
      itemId: mainitemId,
    );
    variantListToUpdate.assignAll(result);
    getAllItems();
    Get.back();
    print("varian Added");
  }

  clearTextField() {
    itemName.clear();
    itemCategory.clear();
    itemPrice.clear();
    itemDescription.clear();
    itemCount.clear();
    itemCost.clear();
    itemDiscount.clear();
    itemBarcode.clear();
  }

  RxList variantList = [].obs;

  addVariants() {
    Map map = {
      "variant_name": variantName.text,
      "variant_count": variantCount.text,
      "variant_price": variantPrice.text,
      "variant_discount":
          variantDiscount.text.isEmpty ? "0" : variantDiscount.text,
      "variant_discount_type": variantDiscountType.value,
    };
    variantList.add(map);
    variantName.clear();
    variantPrice.clear();
    variantCount.clear();
    variantDiscount.clear();
    Get.back();
  }

  getBack() {
    Get.back();
    Get.back();
    Get.to(() => CategoryView());
  }

  showDialogEmptyCategory() {
    Get.dialog(
        AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.all(0),
          content: WillPopScope(
            onWillPop: () => getBack(),
            child: Container(
              height: sizer.height(height: 20, context: Get.context),
              width: sizer.width(width: 40, context: Get.context),
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
                    height: sizer.height(height: 2, context: Get.context),
                  ),
                  Text(
                    "Message",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 15, context: Get.context),
                    ),
                  ),
                  SizedBox(
                    height: sizer.height(height: 3, context: Get.context),
                  ),
                  Text(
                    "Please Add Category on the Category Page",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: sizer.font(fontsize: 11, context: Get.context),
                    ),
                  ),
                  SizedBox(
                    height: sizer.height(height: 1, context: Get.context),
                  ),
                  Container(
                      child: Divider(
                    color: Colors.black,
                  )),
                  GestureDetector(
                    onTap: () async {
                      Get.back();
                      Get.back();

                      Get.to(() => CategoryView());
                    },
                    child: Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: sizer.width(width: 50, context: Get.context),
                      height: sizer.height(height: 5, context: Get.context),
                      child: Text(
                        "OK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:
                              sizer.font(fontsize: 15, context: Get.context),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        barrierDismissible: false);
  }

  showGetDialog({required BuildContext context}) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: sizer.width(width: 5, context: context),
                top: sizer.height(height: 2, context: context),
                right: sizer.width(width: 5, context: context)),
            // color: Colors.pink,
            height: sizer.height(height: 45, context: context),
            width: sizer.width(width: 85, context: context),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center, child: Text("ADD VARIANT")),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: TextField(
                    controller: variantName,
                    obscureText: false,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Small, Medium, Large etc....",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                    controller: variantPrice,
                    obscureText: false,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Price",
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
                      width: sizer.width(width: 45, context: context),
                      child: TextField(
                        controller: variantDiscount,
                        obscureText: false,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 10, context: context)),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Discount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                    Container(
                      width: sizer.width(width: 20, context: context),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.red,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            if (variantDiscountType.value == "Amount") {
                              variantDiscountType.value = "Percent";
                            } else {
                              variantDiscountType.value = "Amount";
                            }
                          },
                          child: Obx(
                            () => Text(
                                variantDiscountType.value == "Amount"
                                    ? "Amount"
                                    : "Percent",
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
                    controller: variantCount,
                    obscureText: false,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Count",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                        width: sizer.width(width: 32, context: context),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              if (variantName.text.isEmpty ||
                                  variantCount.text.isEmpty ||
                                  variantPrice.text.isEmpty) {
                              } else {
                                addVariants();
                              }
                            },
                            child: Text("ADD",
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
                        width: sizer.width(width: 32, context: context),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.red,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              selectedImage = ''.obs;
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

  showGetDialog_for_Adding_Variant(
      {required BuildContext context, required String itemID}) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                left: sizer.width(width: 5, context: context),
                top: sizer.height(height: 2, context: context),
                right: sizer.width(width: 5, context: context)),
            // color: Colors.pink,
            height: sizer.height(height: 45, context: context),
            width: sizer.width(width: 85, context: context),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.center, child: Text("ADD VARIANT")),
                SizedBox(
                  height: sizer.height(height: 2, context: context),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: TextField(
                    controller: variantName,
                    obscureText: false,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Small, Medium, Large etc....",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                    controller: variantPrice,
                    obscureText: false,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Price",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      // color: Colors.red,
                      height: sizer.height(height: 6, context: context),
                      width: sizer.width(width: 45, context: context),
                      child: TextField(
                        controller: variantDiscount,
                        obscureText: false,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 10, context: context)),
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: "Discount",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0))),
                      ),
                    ),
                    Container(
                      width: sizer.width(width: 20, context: context),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.red,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            if (variantDiscountType.value == "Amount") {
                              variantDiscountType.value = "Percent";
                            } else {
                              variantDiscountType.value = "Amount";
                            }
                          },
                          child: Obx(
                            () => Text(
                                variantDiscountType.value == "Amount"
                                    ? "Amount"
                                    : "Percent",
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
                    controller: variantCount,
                    obscureText: false,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: false, signed: false),
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Count",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
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
                        width: sizer.width(width: 32, context: context),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Color(0xff01A0C7),
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              print("object");
                              if (variantName.text.isEmpty ||
                                  variantCount.text.isEmpty ||
                                  variantPrice.text.isEmpty) {
                                print("object");
                              } else {
                                // addVariants();
                                addVariants_Automatically(
                                    variant_discount: variantDiscount.text,
                                    variant_discount_type:
                                        variantDiscountType.value,
                                    variant_name: variantName.text,
                                    variant_count: variantCount.text,
                                    variant_price: variantPrice.text,
                                    mainitemId: itemID);
                              }
                            },
                            child: Text("ADD",
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
                        width: sizer.width(width: 32, context: context),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.red,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () {
                              selectedImage = ''.obs;
                              print("close");
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
      barrierDismissible: false,
    );
  }

  getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      filename.value = result.files.single.path!.split('/').last;
      print(filename);
      imagessss = File(result.files.single.path!);

      String image = base64Encode(file.readAsBytesSync());
      return image.toString();
    } else {}
  }

  getImage_autoUpdate(
      {required String itemid, required String item_store_id}) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      isLoadingUpdatingImage.value = true;
      File file = File(result.files.single.path!);
      filename.value = result.files.single.path!.split('/').last;
      print(filename);
      imagessss = File(result.files.single.path!);
      String image = base64Encode(file.readAsBytesSync());

      var resup = await itemApi.multipartAdd_images_update_images(
          filepath: file.path,
          filename: filename.value,
          itemid: itemid,
          item_store_id: item_store_id);
      print(resup);
      await getAllItems();
      hasUpdated.value = true;
      isLoadingUpdatingImage.value = false;
      return image.toString();
    } else {}
  }

  getBackWillPop() {
    Get.back();
    Get.find<HomepageController>().get_items();
  }
}
