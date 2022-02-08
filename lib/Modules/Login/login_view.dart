import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Login/Login_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobilepos/helpers/sizer.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    var sizer = Sizer();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: sizer.height(height: 100, context: context),
          width: sizer.width(width: 100, context: context),
          padding: EdgeInsets.only(
              left: sizer.width(width: 5, context: context),
              right: sizer.width(width: 5, context: context)),
          child: Column(
            children: [
              SizedBox(
                height: sizer.height(height: 30, context: context),
              ),
              Text(
                "MOBILE POS",
                style: TextStyle(
                    fontSize: sizer.font(fontsize: 25, context: context),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizer.height(height: 10, context: context),
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
                      prefixIcon: Icon(Icons.person),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: "User name",
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
                  width: sizer.width(width: 100, context: context),
                  child: Obx(
                    () => TextField(
                      controller: controller.password,
                      obscureText: controller.dontshowPassword.value,
                      style: TextStyle(
                          fontSize: sizer.font(fontsize: 10, context: context)),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                if (controller.dontshowPassword.value == true) {
                                  controller.dontshowPassword.value = false;
                                } else {
                                  controller.dontshowPassword.value = true;
                                }
                              },
                              child: controller.dontshowPassword.value == true
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.remove_red_eye_outlined)),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0))),
                    ),
                  )),
              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              Material(
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
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () {
                      controller.login(
                          context: context,
                          username: controller.username.text,
                          password: controller.password.text);
                    },
                    child: Obx(
                      () => controller.isLoadingLogin.value == true
                          ? Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size:
                                    sizer.font(fontsize: 10, context: context),
                              ),
                            )
                          : Text("Login",
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

              SizedBox(
                height: sizer.height(height: 2, context: context),
              ),
              // Container(
              //   alignment: Alignment.center,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Dont have an account?",
              //         style: TextStyle(
              //           fontSize: sizer.font(fontsize: 11, context: context),
              //         ),
              //       ),
              //       SizedBox(width: sizer.width(width: 1, context: context)),
              //       GestureDetector(
              //         onTap: () {
              //           Get.to(() => RegistrationView());
              //         },
              //         child: Text(
              //           "Sign up",
              //           style: TextStyle(
              //               fontSize:
              //                   sizer.font(fontsize: 11, context: context),
              //               fontWeight: FontWeight.w700),
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
