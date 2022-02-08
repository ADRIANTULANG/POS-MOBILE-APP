import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Discounts/Discount_controller.dart';
import 'package:mobilepos/helpers/sizer.dart';

class DiscountUpdate extends GetView<DiscountController> {
  const DiscountUpdate({Key? key, required this.discountid}) : super(key: key);
  final String? discountid;
  @override
  Widget build(BuildContext context) {
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
          "DISCOUNT UPDATE",
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
        padding: EdgeInsets.only(
            left: sizer.width(width: 3, context: context),
            right: sizer.width(width: 3, context: context)),
        child: Column(
          children: [
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount name: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 12, context: context)),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 65, context: context),
                  child: TextField(
                    obscureText: false,
                    controller: controller.discountName,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.person),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount value: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 12, context: context)),
                ),
                Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  height: sizer.height(height: 6, context: context),
                  width: sizer.width(width: 65, context: context),
                  child: TextField(
                    obscureText: false,
                    controller: controller.discountValue,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: sizer.font(fontsize: 10, context: context)),
                    decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.person),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0))),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount type: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizer.font(fontsize: 12, context: context)),
                ),
                Container(
                  height: sizer.height(height: 5.5, context: context),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      // color: Colors.red,
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      )),
                  child: PopupMenuButton(
                    // icon: Icon(Icons.arrow_drop_down_outlined),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: sizer.height(height: 6, context: context),
                      width: sizer.width(width: 64, context: context),
                      padding: EdgeInsets.only(
                          left: sizer.width(width: 4, context: context)),
                      child: Obx(() => Text(
                            controller.discounttypevalue.value,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    sizer.font(fontsize: 10, context: context)),
                          )),
                    ),
                    itemBuilder: (context) {
                      return List.generate(controller.discounttypes.length,
                          (i) {
                        return PopupMenuItem(
                          onTap: () async {
                            controller.discounttypevalue.value =
                                controller.discounttypes[i];
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: sizer.height(height: 2, context: context)),
                            child: Container(
                              width: sizer.width(width: 100, context: context),
                              child: Text(controller.discounttypes[i]),
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            Expanded(
                child: Container(
                    // color: Colors.green,
                    )),
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
                      controller.update_discount(
                          context: context,
                          discountid: int.parse(discountid!.toString()));
                    },
                    child: Obx(
                      () => controller.isLoadingUpdate.value == true
                          ? Container(
                              height: sizer.height(height: 5, context: context),
                              width: sizer.width(width: 100, context: context),
                              child: Center(
                                child: SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: sizer.font(
                                      fontsize: 10, context: context),
                                ),
                              ),
                            )
                          : Text("Update",
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
            )
          ],
        ),
      ),
    );
  }
}
