import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Expenses/Expenses_controller.dart';
import 'package:mobilepos/helpers/sizer.dart';

class ExpensesView extends GetView<ExpensesController> {
  const ExpensesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ExpensesController());
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
          "EXPENSES",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      body: Container(
        width: sizer.width(width: 100, context: context),
        height: sizer.height(height: 100, context: context),
        padding: EdgeInsets.only(
          left: sizer.width(width: 5, context: context),
          top: sizer.width(width: 5, context: context),
          right: sizer.width(width: 5, context: context),
        ),
        color: Colors.grey[200],
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // controller.showDialogExpenses(
                //     context: context, action: "Set Balance");
              },
              child: Container(
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
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                alignment: Alignment.center,
                width: sizer.width(width: 100, context: context),
                height: sizer.height(height: 15, context: context),
                child: Column(
                  children: [
                    Container(
                      height: sizer.height(height: 3, context: context),
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.red,
                        alignment: Alignment.topLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "TOTAL EXPENSES: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: sizer.font(
                                          fontsize: 17, context: context)),
                                ),
                                Obx(
                                  () => Text(
                                    "₱ ${controller.count_total_Expenses().value.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: sizer.font(
                                            fontsize: 17, context: context)),
                                  ),
                                ),
                              ],
                            ).paddingOnly(
                              right: sizer.width(width: 2, context: context),
                              left: sizer.width(width: 2, context: context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: sizer.height(height: 3, context: context),
                      alignment: Alignment.topCenter,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              color: Colors.lightBlue,
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
                    controller.showDialogExpenses(
                        context: context, action: "Expenses");
                  },
                  child: Text("Create Expenses",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                              fontSize:
                                  sizer.font(fontsize: 10, context: context))
                          .copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 2, context: context),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                alignment: Alignment.center,
                width: sizer.width(width: 100, context: context),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.expensesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          top: sizer.height(height: 1, context: context),
                          right: sizer.width(width: 2, context: context),
                          left: sizer.width(width: 2, context: context),
                        ),
                        child: Container(
                            padding: EdgeInsets.only(
                              top: sizer.height(height: 1, context: context),
                              right: sizer.width(width: 1, context: context),
                              left: sizer.width(width: 1, context: context),
                            ),
                            height: sizer.height(height: 10, context: context),
                            width: sizer.width(width: 100, context: context),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Expenses ID: " +
                                          controller
                                              .expensesList[index].expensesId
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: sizer.font(
                                              fontsize: 14, context: context)),
                                    ),
                                    Text(
                                      controller.dateTimeConverter(
                                          datetimeString: controller
                                              .expensesList[index]
                                              .expensesDateCreated
                                              .toString()),
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontSize: sizer.font(
                                              fontsize: 11, context: context)),
                                    ),
                                  ],
                                ),
                                Text(
                                  "₱ " +
                                      controller
                                          .expensesList[index].expensesAmount,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: sizer.font(
                                          fontsize: 12, context: context)),
                                ),
                                Text(
                                  "Note: " +
                                      controller
                                          .expensesList[index].expensesNote,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: sizer.font(
                                          fontsize: 12, context: context)),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
                // height: sizer.height(height: 15, context: context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
