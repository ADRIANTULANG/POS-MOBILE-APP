// import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Registration/Registration_controller.dart';
import 'package:mobilepos/helpers/sizer.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
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
          "REGISTER",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizer.font(fontsize: 20, context: context)),
        ),
        centerTitle: true,
        // leading: Icon(Icons.),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          color: Colors.grey[200],
          padding: EdgeInsets.only(
              left: sizer.width(width: 4, context: context),
              right: sizer.width(width: 4, context: context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: sizer.height(height: 35, context: context),
              ),
              Container(
                alignment: Alignment.center,
                // color: Colors.red,
                height: sizer.height(height: 6, context: context),
                width: sizer.width(width: 100, context: context),
                child: TextField(
                  obscureText: false,
                  controller: controller.username,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "User name",
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
                  obscureText: false,
                  controller: controller.password,
                  style: TextStyle(
                      fontSize: sizer.font(fontsize: 10, context: context)),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Container(
                alignment: Alignment.center,
                height: sizer.height(height: 6, context: context),
                width: sizer.width(width: 100, context: context),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    )),
                padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context)),
                child: DropdownButton(
                  underline: SizedBox(),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal,
                    fontSize: sizer.font(fontsize: 10.5, context: context),
                  ),
                  isExpanded: true,
                  // Initial Value
                  value: controller.dropdownvalue.value,

                  // Down Arrow Icon
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.white,
                  ),

                  // Array list of items
                  items: controller.items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    controller.dropdownvalue.value = newValue!;
                  },
                ),
              ),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              // Container(
              //   height: sizer.height(height: 10, context: context),
              //   width: sizer.width(width: 100, context: context),
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 1, color: Colors.grey),
              //       borderRadius: BorderRadius.all(Radius.circular(10))),
              //   child: Obx(
              //     () => controller.selectedImage.value == ""
              //         ? IconButton(
              //             onPressed: () async {
              //               controller.selectedImage.value =
              //                   await controller.getImage();
              //             },
              //             icon: Icon(
              //               Icons.add_a_photo,
              //               color: Colors.grey,
              //             ))
              //         : GestureDetector(
              //             onTap: () async {
              //               controller.selectedImage.value =
              //                   await controller.getImage();
              //             },
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 border: Border.all(width: 1, color: Colors.grey),
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(10)),
              //                 image: DecorationImage(
              //                     fit: BoxFit.cover,
              //                     image: FileImage(
              //                         File(controller.selectedImage.value))),
              //               ),
              //             ),
              //           ),
              //   ),
              // ),
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
                      if (controller.username.text.isNotEmpty &&
                          controller.password.text.isNotEmpty) {
                        controller.createUser(
                            context: context,
                            sizer: sizer,
                            username: controller.username.text,
                            password: controller.password.text,
                            usertype:
                                controller.dropdownvalue.value.toString());
                      } else {
                        controller.showDialogMissingFields(
                            context: context, sizer: sizer);
                      }
                    },
                    child: Text("Create User",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                                fontSize:
                                    sizer.font(fontsize: 10, context: context))
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
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
