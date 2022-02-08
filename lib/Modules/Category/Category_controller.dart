import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Category/Category_api.dart';
import 'package:mobilepos/Modules/Category/Category_model.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';
// import 'package:mobilepos/helpers/storage.dart';

class CategoryController extends GetxController {
  RxList catList = [].obs;
  RxList<Categories> categoryList = <Categories>[].obs;
  RxBool isLoading = true.obs;
  RxBool isTapFloating = false.obs;
  final sizer = Sizer();
  TextEditingController categoryName = TextEditingController();
  @override
  void onInit() {
    getAllCategory();
    super.onInit();
  }

  backFunction() {
    isTapFloating.value = false;
    Get.back();
  }

  getAllCategory() async {
    var result = await CategoryApi.get_all_Categories(
        storeid: Get.find<StorageService>().box.read('storeid'));
    categoryList.assignAll(result);
    isLoading.value = false;
  }

  addCategory({required String categoryname}) async {
    var result = await CategoryApi.add_Category_api(
        categoryname: categoryname,
        storeid: Get.find<StorageService>().box.read('storeid'));
    if (result == true) {
      getAllCategory();
      Get.back();
    } else {}
  }

  deleteCategories({required String categoryid}) async {
    var result = await CategoryApi.deleteCat(
      categoryid: categoryid,
    );
    if (result == true) {
      await getAllCategory();
    } else {}
  }

  updateCategories(
      {required String categoryid, required String categoryname}) async {
    var result = await CategoryApi.updateCat(
        categoryid: categoryid, categoryname: categoryname);
    if (result == true) {
      await getAllCategory();
      Get.back();
    } else {}
  }

  showDialog_addCategory({required BuildContext context}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: WillPopScope(
          onWillPop: () => backFunction(),
          child: Container(
              height: sizer.height(height: 15, context: context),
              width: sizer.width(width: 20, context: context),
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: sizer.height(height: 6, context: context),
                    width: sizer.width(width: 100, context: context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: TextField(
                      obscureText: false,
                      controller: categoryName,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          fontSize: sizer.font(fontsize: 10, context: context)),
                      decoration: InputDecoration.collapsed(
                        hintText: "Category Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizer.height(height: 2, context: context),
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
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          addCategory(categoryname: categoryName.text);
                        },
                        child: Text("ADD CATEGORY ",
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
              )),
        ),
      ),
      barrierDismissible: false,
    );
  }

  showDialog_Update_Category({
    required BuildContext context,
    required String name,
    required String categoryid,
  }) {
    categoryName.text = name;
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: WillPopScope(
          onWillPop: () => backFunction(),
          child: Container(
              height: sizer.height(height: 15, context: context),
              width: sizer.width(width: 20, context: context),
              color: Colors.transparent,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: sizer.height(height: 6, context: context),
                    width: sizer.width(width: 100, context: context),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    child: TextField(
                      obscureText: false,
                      controller: categoryName,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                          fontSize: sizer.font(fontsize: 10, context: context)),
                      decoration: InputDecoration.collapsed(
                        hintText: "Category Name",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizer.height(height: 2, context: context),
                  ),
                  Material(
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
                        onPressed: () {
                          updateCategories(
                              categoryid: categoryid,
                              categoryname: categoryName.text);
                        },
                        child: Text("UPDATE ",
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
              )),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
