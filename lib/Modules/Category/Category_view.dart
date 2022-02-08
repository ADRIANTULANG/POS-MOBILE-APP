import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Category/Category_controller.dart';
import 'package:mobilepos/helpers/sizer.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryController());
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
          "PRODUCT CATEGORIES",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        color: Colors.grey[200],
        child: Obx(
          () => controller.isLoading.value == true
              ? Center(
                  child: Container(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                )
              : controller.categoryList.isEmpty
                  ? Center(
                      child: Container(child: Text("No Categories for now.")),
                    )
                  : ListView.builder(
                      itemCount: controller.categoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: sizer.width(width: 2, context: context),
                            right: sizer.width(width: 2, context: context),
                            top: sizer.height(height: 2, context: context),
                          ),
                          child: Container(
                            height: sizer.height(height: 5, context: context),
                            width: sizer.width(width: 100, context: context),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: sizer.width(
                                          width: 2, context: context)),
                                  child: Text(
                                    controller.categoryList[index].categoryName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: sizer.font(
                                            fontsize: 12, context: context)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.deleteCategories(
                                            categoryid: controller
                                                .categoryList[index].categoryId
                                                .toString());
                                      },
                                      icon: Icon(
                                        Icons.delete_sharp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Padding(
                                        child: IconButton(
                                          onPressed: () {
                                            controller
                                                .showDialog_Update_Category(
                                              context: context,
                                              name: controller
                                                  .categoryList[index]
                                                  .categoryName
                                                  .toString(),
                                              categoryid: controller
                                                  .categoryList[index]
                                                  .categoryId
                                                  .toString(),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            right: sizer.width(
                                                width: 2, context: context))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isTapFloating.value = true;
          controller.showDialog_addCategory(context: context);
        },
        child: Container(
            height: sizer.height(height: 40, context: context),
            width: sizer.width(width: 40, context: context),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
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
            child: Icon(Icons.add)),
      ),
    );
  }
}
