import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Expenses/Expenses_api.dart';
import 'package:mobilepos/Modules/Expenses/Expenses_model.dart';
import 'package:mobilepos/helpers/sizer.dart';
// import 'package:mobilepos/helpers/storage.dart';

class ExpensesController extends GetxController {
  var sizer = Sizer();
  TextEditingController amount = TextEditingController();
  TextEditingController note = TextEditingController();
  RxList<Expenses> expensesList = <Expenses>[].obs;
  @override
  void onInit() {
    get_all_Expense();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String dateTimeConverter({required String datetimeString}) {
    DateTime datetime = DateTime.parse(datetimeString);

    String monthString = '';
    if (datetime.month == 1) {
      monthString = 'January';
    } else if (datetime.month == 2) {
      monthString = 'February';
    } else if (datetime.month == 3) {
      monthString = 'March';
    } else if (datetime.month == 4) {
      monthString = 'April';
    } else if (datetime.month == 5) {
      monthString = 'May';
    } else if (datetime.month == 6) {
      monthString = 'June';
    } else if (datetime.month == 7) {
      monthString = 'Jully';
    } else if (datetime.month == 8) {
      monthString = 'August';
    } else if (datetime.month == 9) {
      monthString = 'September';
    } else if (datetime.month == 10) {
      monthString = 'October';
    } else if (datetime.month == 11) {
      monthString = 'Novermber';
    } else if (datetime.month == 12) {
      monthString = 'December';
    }
    String stringtoReturn = monthString +
        " " +
        datetime.day.toString() +
        " ," +
        datetime.year.toString();
    return stringtoReturn;
  }

  showDialogExpenses({required BuildContext context, required String action}) {
    Get.dialog(AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.all(0),
      content: Container(
        height: sizer.height(height: 30, context: context),
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
              action,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizer.font(fontsize: 15, context: context),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 3, context: context),
            ),
            Container(
              alignment: Alignment.center,
              // color: Colors.red,

              height: sizer.height(height: 6, context: context),
              width: sizer.width(width: 35, context: context),
              child: TextField(
                keyboardType: TextInputType.number,
                obscureText: false,
                controller: amount,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: sizer.font(fontsize: 10, context: context)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
              ),
            ),
            SizedBox(
              height: sizer.height(height: 1, context: context),
            ),
            Container(
              alignment: Alignment.center,
              // color: Colors.red,

              height: sizer.height(height: 6, context: context),
              width: sizer.width(width: 35, context: context),
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                controller: note,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: sizer.font(fontsize: 10, context: context)),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Note",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0))),
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
                      "Cancel",
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
                    if (action == "Expenses") {
                      create_expenses(context: context);
                    } else {
                      // Get.find<StorageService>()
                      //     .setBalance(balance: amount.text);
                    }
                    Get.back();
                  },
                  child: Container(
                    // color: Colors.red,
                    alignment: Alignment.center,

                    height: sizer.height(height: 5, context: context),
                    child: Text(
                      "Add",
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

  create_expenses({required BuildContext context}) async {
    String currentdate = DateTime.now().year.toString() +
        "-" +
        DateTime.now().month.toString() +
        "-" +
        DateTime.now().day.toString();
    var result = await ExpensesApi.add_expenses(
        amount: amount.text, note: note.text, dateOnly: currentdate);
    print(result);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Expenses Recorded'),
    ));
    get_all_Expense();
  }

  get_all_Expense() async {
    var result = await ExpensesApi.getExpenses();
    expensesList.assignAll(result.reversed);
  }

  RxDouble count_total_Expenses() {
    var total = 0.0;
    for (var i = 0; i < expensesList.length; i++) {
      total = total + double.parse(expensesList[i].expensesAmount);
    }
    return total.obs;
  }
}
