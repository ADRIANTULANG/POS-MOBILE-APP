import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/BluetoothSettings/BluetoothSettings_view.dart';
import 'package:mobilepos/Modules/Category/Category_view.dart';
import 'package:mobilepos/Modules/Checkout/Checkout_view.dart';
import 'package:mobilepos/Modules/Discounts/Discount_Display_Discount.dart';

import 'package:mobilepos/Modules/Expenses/Expenses_view.dart';
import 'package:mobilepos/Modules/Homepage/homepage_controller.dart';
import 'package:mobilepos/Modules/Items/Item_view.dart';
import 'package:mobilepos/Modules/Purchasehistory/PurchasedHistory_view.dart';
import 'package:mobilepos/helpers/DiscountServices.dart';
import 'package:mobilepos/helpers/bluetooth_services.dart';
import 'package:mobilepos/helpers/connectivity.dart';
import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/sizer.dart';
import 'package:mobilepos/helpers/storage.dart';
// import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizer = Sizer();
    Get.put(HomepageController());
    Get.put(DiscountServices());
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
        title: Obx(
          () => controller.showSearchField.value == false
              ? Text(
                  "MOBILE POS",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 20, context: context)),
                )
              : Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: TextField(
                    onChanged: (value) {
                      controller.searchFunctionNew(stringtosearch: value);
                    },
                    controller: controller.searchField,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
        ),
        actions: [
          Obx(
            () => controller.showSearchField.value == false
                ? IconButton(
                    icon: Icon(Icons.search),
                    // tooltip: 'Open shopping cart',
                    onPressed: () {
                      controller.searchField.clear();
                      controller.showSearchField.value = true;

                      // handle the press
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.done),

                    // tooltip: 'Open shopping cart',
                    onPressed: () {
                      controller.showSearchField.value = false;
                      controller.itemsList
                          .assignAll(controller.itemsList_Master);
                      // handle the press
                    },
                  ),
          ),
          // IconButton(
          //   icon: Icon(Icons.qr_code_scanner_rounded),
          //   // tooltip: 'Open shopping cart',
          //   onPressed: () {
          //     Get.to(QRViewExample());

          //     // handle the press
          //   },
          // ),
          SizedBox(
            width: sizer.width(width: 2, context: context),
          )
        ],
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: sizer.width(width: 22, context: context),
                      width: sizer.width(width: 22, context: context),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.black),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/profileDefault.jpg"))),
                    ),
                    SizedBox(
                      height: sizer.height(height: 1, context: context),
                    ),
                    Container(
                      child: Text(
                        Get.find<StorageService>()
                            .box
                            .read('userlogin')
                            .toString()
                            .capitalizeFirst
                            .toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize:
                                sizer.font(fontsize: 15, context: context),
                            color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                // color: Colors.grey[200],
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
            ListTile(
              title: Text('Category'),
              leading: Icon(Icons.category_sharp),
              onTap: () {
                if (Get.find<StorageService>()
                        .box
                        .read('usertype')
                        .toString()
                        .toLowerCase() ==
                    "admin") {
                  Get.back();
                  if (Get.find<ConnectivityService>().hasConnection.value ==
                      true) {
                    Get.to(() => CategoryView());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Open Internet and Restart the app.'),
                    ));
                  }
                } else {
                  Get.back();
                  controller.showDialog(context: context, word: "Admins");
                }
              },
            ),
            ListTile(
              title: Text('Open Cash Drawer'),
              leading: Icon(Icons.cases_rounded),
              onTap: () {
                if (Get.find<BluetoothServices>().bluetoothState == 12 ||
                    Get.find<BluetoothServices>().bluetoothState == 1) {
                  if (Get.find<BluetoothServices>().printerStatus ==
                      "Connected") {
                    controller.print_to_open_Drawer();
                  }
                }
              },
            ),
            ListTile(
              title: Text('Items'),
              leading: Icon(Icons.list_sharp),
              onTap: () {
                print(Get.find<StorageService>()
                    .box
                    .read('usertype')
                    .toString()
                    .toLowerCase());
                if (Get.find<StorageService>()
                            .box
                            .read('usertype')
                            .toString()
                            .toLowerCase() ==
                        "admin" ||
                    Get.find<StorageService>()
                            .box
                            .read('usertype')
                            .toString()
                            .toLowerCase() ==
                        "employee") {
                  Get.back();
                  if (Get.find<ConnectivityService>().hasConnection.value ==
                      true) {
                    Get.to(() => ItemView());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Open Internet and Restart the app.'),
                    ));
                  }
                } else {
                  Get.back();
                  controller.showDialog(
                      context: context, word: "Admins and Employees");
                }
              },
            ),
            ListTile(
              title: Text('Sales History'),
              leading: Icon(
                Icons.list_alt_sharp,
              ),
              onTap: () {
                Get.to(() => PurchasedHistoryView());
              },
            ),
            ListTile(
              title: Text('Bluetooth Settings'),
              leading: Icon(Icons.print_rounded),
              onTap: () {
                Get.to(() => BluetoothSettingsView());
              },
            ),
            ListTile(
              title: Text('Discount Settings'),
              leading: Icon(Icons.payment),
              onTap: () {
                if (Get.find<ConnectivityService>().hasConnection.value ==
                    true) {
                  Get.to(() => DiscountListView());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Open Internet and Restart the app.'),
                  ));
                }
              },
            ),
            ListTile(
              title: Text('Expenses'),
              leading: Icon(Icons.paid),
              onTap: () {
                if (Get.find<ConnectivityService>().hasConnection.value ==
                    true) {
                  Get.to(() => ExpensesView());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Open Internet and Restart the app.'),
                  ));
                }
              },
            ),
            ListTile(
              title: Obx(() => Text(controller.view.value)),
              leading: Obx(
                () => controller.isGridView.value == true
                    ? Icon(Icons.grid_3x3)
                    : Icon(Icons.list),
              ),
              trailing: Container(
                child: Obx(
                  () => Switch(
                      onChanged: (value) {
                        if (controller.isSwitched.value == true) {
                          controller.view.value = 'Grid View';
                          controller.isGridView.value = true;
                          controller.isSwitched.value = false;
                        } else {
                          controller.view.value = 'List View';
                          controller.isGridView.value = false;
                          controller.isSwitched.value = true;
                        }
                      },
                      value: controller.isSwitched.value,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.grey[350],
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey[350]),
                ),
              ),
            ),
            ListTile(
              title: Text('Log out'),
              leading: Icon(Icons.logout),
              onTap: () {
                if (Get.find<ConnectivityService>().hasConnection.value ==
                    true) {
                  Get.find<StorageService>().removeUsers();
                  Get.back();
                  controller.showDialogLogOut(context: context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Open Internet and Restart the app.'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        height: sizer.height(height: 100, context: context),
        width: sizer.width(width: 100, context: context),
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: Obx(
          () => controller.isLoadingItems.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Obx(
                      () => Expanded(
                        child:
                            controller.itemsList.length == 0 ||
                                    controller.itemsList.isEmpty
                                ? Center(child: Text("No items for now."))
                                : controller.isGridView.value == true
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                        ),
                                        itemCount: controller.itemsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: sizer.width(
                                                  width: 1, context: context),
                                              right: sizer.width(
                                                  width: 1, context: context),
                                              top: sizer.width(
                                                  width: 2, context: context),
                                              bottom: sizer.width(
                                                  width: 1, context: context),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                if (controller.itemsList[index]
                                                        .itemHasVariants ==
                                                    1) {
                                                  controller
                                                      .showDialog_add_or_remove_quantity_hasVariants(
                                                          variantList: controller
                                                              .itemsList[index]
                                                              .itemListOfVariants,
                                                          itemID: controller
                                                              .itemsList[index]
                                                              .itemId,
                                                          context: context);
                                                } else {
                                                  print("grid view");
                                                  if (double.parse(controller
                                                          .itemsList[index]
                                                          .itemCount) ==
                                                      0) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Item out of stock'),
                                                    ));
                                                  } else {
                                                    if (double.parse(controller
                                                            .itemsList[index]
                                                            .itemCount) ==
                                                        controller
                                                            .itemsList[index]
                                                            .itemQuantity
                                                            .value) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text(
                                                            'Maximum count of item reach'),
                                                      ));
                                                    } else {
                                                      controller
                                                          .add_quantity_no_variants(
                                                              mainItemID:
                                                                  controller
                                                                      .itemsList[
                                                                          index]
                                                                      .itemId);
                                                    }
                                                  }
                                                }
                                              },
                                              child: Container(
                                                // color: Colors.grey,

                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      children: [
                                                        controller
                                                                        .itemsList[
                                                                            index]
                                                                        .itemImage ==
                                                                    "" ||
                                                                Get.find<ConnectivityService>()
                                                                        .hasConnection
                                                                        .value ==
                                                                    false
                                                            ? Container(
                                                                height: sizer
                                                                    .height(
                                                                        height:
                                                                            13,
                                                                        context:
                                                                            context),
                                                                width: sizer.width(
                                                                    width: 100,
                                                                    context:
                                                                        context),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xFFd6d6d6)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                  ),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: AssetImage(
                                                                          "assets/images/item.jpg")),
                                                                ),
                                                              )
                                                            : Container(
                                                                height: sizer
                                                                    .height(
                                                                        height:
                                                                            13,
                                                                        context:
                                                                            context),
                                                                width: sizer.width(
                                                                    width: 100,
                                                                    context:
                                                                        context),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color(
                                                                          0xFFd6d6d6)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20),
                                                                  ),
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: NetworkImage(
                                                                        "$image_Endpoint/${controller.itemsList[index].itemImage}"),
                                                                  ),
                                                                ),
                                                              ),
                                                        Positioned(
                                                          right: 10,
                                                          top: 10,
                                                          child: Obx(
                                                            () => Container(
                                                              padding: EdgeInsets.only(
                                                                  left: sizer.width(
                                                                      width: 2,
                                                                      context:
                                                                          context),
                                                                  right: sizer.width(
                                                                      width: 2,
                                                                      context:
                                                                          context)),
                                                              decoration: controller
                                                                          .itemsList[
                                                                              index]
                                                                          .itemQuantity
                                                                          .value ==
                                                                      0
                                                                  ? BoxDecoration()
                                                                  : BoxDecoration(
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
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.white),
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(6)),
                                                                    ),
                                                              child: Text(
                                                                controller
                                                                            .itemsList[
                                                                                index]
                                                                            .itemQuantity
                                                                            .value ==
                                                                        0
                                                                    ? ""
                                                                    : controller
                                                                        .itemsList[
                                                                            index]
                                                                        .itemQuantity
                                                                        .value
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: sizer.font(
                                                                        fontsize:
                                                                            15,
                                                                        context:
                                                                            context)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 0,
                                                      thickness: .3,
                                                      color: Colors.black,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20))),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: sizer.height(
                                                                  height: 0.5,
                                                                  context:
                                                                      context),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: sizer.width(
                                                                          width:
                                                                              40,
                                                                          context:
                                                                              context),
                                                                      padding: EdgeInsets.only(
                                                                          left: sizer.width(
                                                                              width: 1,
                                                                              context: context)),
                                                                      child:
                                                                          Text(
                                                                        controller
                                                                            .itemsList[index]
                                                                            .itemName
                                                                            .toString()
                                                                            .capitalizeFirst
                                                                            .toString(),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: sizer.font(fontsize: 20, context: context)),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: sizer.height(
                                                                  height: 0.5,
                                                                  context:
                                                                      context),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.only(
                                                                  left: sizer.width(
                                                                      width:
                                                                          1.5,
                                                                      context:
                                                                          context)),
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              width: sizer.width(
                                                                  width: 100,
                                                                  context:
                                                                      context),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : ListView.builder(
                                        itemCount: controller.itemsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (controller.itemsList[index]
                                                      .itemHasVariants ==
                                                  1) {
                                                controller
                                                    .showDialog_add_or_remove_quantity_hasVariants(
                                                        variantList: controller
                                                            .itemsList[index]
                                                            .itemListOfVariants,
                                                        itemID: controller
                                                            .itemsList[index]
                                                            .itemId,
                                                        context: context);
                                              } else {
                                                print("grid view");
                                                if (double.parse(controller
                                                        .itemsList[index]
                                                        .itemCount) ==
                                                    0) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Item out of stock'),
                                                  ));
                                                } else {
                                                  if (double.parse(controller
                                                          .itemsList[index]
                                                          .itemCount) ==
                                                      controller
                                                          .itemsList[index]
                                                          .itemQuantity
                                                          .value) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      content: Text(
                                                          'Maximum count of item reach'),
                                                    ));
                                                  } else {
                                                    controller
                                                        .add_quantity_no_variants(
                                                            mainItemID:
                                                                controller
                                                                    .itemsList[
                                                                        index]
                                                                    .itemId);
                                                  }
                                                }
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: sizer.width(
                                                      width: 2,
                                                      context: context),
                                                  right: sizer.width(
                                                      width: 2,
                                                      context: context)),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: sizer.height(
                                                        height: 0.5,
                                                        context: context),
                                                  ),
                                                  Container(
                                                    height: sizer.height(
                                                        height: 12,
                                                        context: context),
                                                    width: sizer.width(
                                                        width: 100,
                                                        context: context),
                                                    padding: EdgeInsets.only(
                                                        left: sizer.width(
                                                            width: 2,
                                                            context: context),
                                                        right: sizer.width(
                                                            width: 2,
                                                            context: context)),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            controller
                                                                        .itemsList[
                                                                            index]
                                                                        .itemImage !=
                                                                    ""
                                                                ? Container(
                                                                    height: sizer.height(
                                                                        height:
                                                                            10,
                                                                        context:
                                                                            context),
                                                                    width: sizer.width(
                                                                        width:
                                                                            23,
                                                                        context:
                                                                            context),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .tealAccent,
                                                                          width: sizer.font(
                                                                              fontsize: 2,
                                                                              context: context)),
                                                                      image:
                                                                          DecorationImage(
                                                                        fit: BoxFit
                                                                            .cover,
                                                                        image: NetworkImage(
                                                                            "$image_Endpoint/${controller.itemsList[index].itemImage}"),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: sizer.height(
                                                                        height:
                                                                            10,
                                                                        context:
                                                                            context),
                                                                    width: sizer.width(
                                                                        width:
                                                                            23,
                                                                        context:
                                                                            context),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .greenAccent,
                                                                          width: sizer.font(
                                                                              fontsize: 2,
                                                                              context: context)),
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          image:
                                                                              AssetImage("assets/images/item.jpg")),
                                                                    ),
                                                                  ),
                                                            SizedBox(
                                                              width: sizer.width(
                                                                  width: 2,
                                                                  context:
                                                                      context),
                                                            ),
                                                            Container(
                                                              height: sizer.height(
                                                                  height: 10,
                                                                  context:
                                                                      context),
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize: sizer.font(
                                                                              fontsize: 16,
                                                                              context: context)),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Obx(
                                                                      () =>
                                                                          Text(
                                                                        controller.itemsList[index].itemQuantity.value ==
                                                                                0
                                                                            ? ""
                                                                            : "₱ " +
                                                                                controller.itemsList[index].itemPrice.value.toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: Colors.grey,
                                                                            fontSize: sizer.font(fontsize: 10, context: context)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Obx(
                                                                    () =>
                                                                        Container(
                                                                      padding: EdgeInsets.only(
                                                                          left: sizer.width(
                                                                              width:
                                                                                  2,
                                                                              context:
                                                                                  context),
                                                                          right: sizer.width(
                                                                              width: 2,
                                                                              context: context)),
                                                                      decoration: controller.itemsList[index].itemQuantity.value ==
                                                                              0
                                                                          ? BoxDecoration()
                                                                          : BoxDecoration(
                                                                              gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [
                                                                                Colors.cyanAccent,
                                                                                Colors.greenAccent,
                                                                                Colors.lightBlue,
                                                                                Colors.tealAccent
                                                                              ]),
                                                                              border: Border.all(width: 1, color: Colors.white),
                                                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                                                            ),
                                                                      child:
                                                                          Text(
                                                                        controller.itemsList[index].itemQuantity.value ==
                                                                                0
                                                                            ? ""
                                                                            : controller.itemsList[index].itemQuantity.value.toString(),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: Colors.white,
                                                                            fontSize: sizer.font(fontsize: 15, context: context)),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          height: sizer.height(
                                                              height: 10,
                                                              context: context),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: sizer.height(
                                                        height: 1,
                                                        context: context),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: sizer.width(width: 2, context: context),
                              right: sizer.width(width: 2, context: context)),
                          width: sizer.width(width: 50, context: context),
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
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () {
                                  // Get.find<StorageService>().clearBeforeUpdating();
                                  if (Get.find<ConnectivityService>()
                                          .hasConnection
                                          .value ==
                                      true) {
                                    controller.get_items();
                                  } else {
                                    Get.find<HomepageController>()
                                        .get_items_offline_mode();
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.clear_all_rounded),
                                    Text("CLEAR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                                fontSize: sizer.font(
                                                    fontsize: 10,
                                                    context: context))
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: sizer.width(width: 2, context: context),
                              right: sizer.width(width: 2, context: context)),
                          width: sizer.width(width: 50, context: context),
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
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                onPressed: () async {
                                  controller.showSearchField.value = false;
                                  controller.add_to_cart();
                                  await Get.to(() => CheckoutView());
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.checklist_sharp),
                                    Text("CHECKOUT",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                                fontSize: sizer.font(
                                                    fontsize: 10,
                                                    context: context))
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
