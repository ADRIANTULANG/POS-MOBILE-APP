import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobilepos/Modules/Registration/Registration_api.dart';

import 'package:mobilepos/helpers/sizer.dart';

class RegistrationController extends GetxController {
  final box = GetStorage();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController usertype = TextEditingController();
  RxString selectedImage = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      // File file = File(result.files.single.path!);
      print(result.files.single.path!);
      return result.files.single.path!.toString();
    } else {
      // User canceled the picker
      return "";
    }
  }

  var items = ['Admin', 'Cashier'].obs;
  RxString dropdownvalue = 'Admin'.obs;

  createUser(
      {required String username,
      required String password,
      required String usertype,
      required BuildContext context,
      required Sizer sizer}) async {
    var result = await RegistrationApi.check_if_account_exist(
        usertype: usertype, username: username, password: password);
    if (result == true) {
      var res = await RegistrationApi.create_account(
          usertype: usertype, username: username, password: password);
      if (res == true) {
        showDialogMessage(
            context: context,
            sizer: sizer,
            message: "Account Created Successfully!");
      } else {
        showDialogMessage(context: context, sizer: sizer, message: "Fail!");
      }
    } else {
      showDialogMessage(
          context: context, sizer: sizer, message: "User already exist!");
    }
  }

  showDialogMessage(
      {required BuildContext context,
      required Sizer sizer,
      required String message}) {
    username.clear();
    password.clear();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          height: sizer.height(height: 18, context: context),
          width: sizer.width(width: 20, context: context),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            // color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
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
                "$message",
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
                  // padding: EdgeInsets.only(
                  //     left: sizer.width(width: 2, context: context),
                  //     right: sizer.width(width: 2, context: context)),
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
      ),
    );
  }

  showDialogMissingFields(
      {required BuildContext context, required Sizer sizer}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.all(0),
        content: Container(
          height: sizer.height(height: 18, context: context),
          width: sizer.width(width: 20, context: context),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            // color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
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
                "Missing Inputs!",
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
                  // padding: EdgeInsets.only(
                  //     left: sizer.width(width: 2, context: context),
                  //     right: sizer.width(width: 2, context: context)),
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
      ),
    );
  }
}
