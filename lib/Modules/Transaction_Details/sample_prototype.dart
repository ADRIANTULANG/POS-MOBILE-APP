import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_Controller.dart';
import 'package:mobilepos/helpers/sizer.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:visibility_detector/visibility_detector.dart';

class SamplePrototype extends GetView<TransactionDetailsController> {
  const SamplePrototype({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Sizer sizer = Sizer();
    return Scaffold(
        body: SafeArea(
          child: Container(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: sizer.height(height: 2.1, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Color(0xFFebebeb),
                            border: Border.all(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(32)),
                        // color: Colors.red,
                        height: sizer.height(height: 4.5, context: context),
                        width: sizer.width(width: 78, context: context),
                        child: TextField(
                          obscureText: false,
                          // controller: controller.username,
                          style: TextStyle(
                              fontSize:
                                  sizer.font(fontsize: 11, context: context)),
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: Color(0xFFebebeb),
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                              size: sizer.font(fontsize: 16, context: context),
                            ),
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
                            hintText: "Search Item",
                            hintStyle: TextStyle(color: Color(0xFFc1c1c1)),

                            // focusedBorder: OutlineInputBorder(
                            //     // borderSide: BorderSide(color: Colors.red),
                            //     borderRadius: BorderRadius.circular(32.0)),
                            // border: OutlineInputBorder(
                            //     // borderSide: BorderSide(
                            //     //     color: Colors.white60, width: 0.4),
                            //     borderRadius: BorderRadius.circular(32.0)),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_basket_rounded))
                    ],
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 1, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: sizer.width(width: 1, context: context),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: sizer.height(height: 4, context: context),
                        width: sizer.width(width: 13, context: context),
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 3))),
                        child: Text(
                          "All",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  sizer.font(fontsize: 12, context: context)),
                        ),
                      ),
                      SizedBox(
                        width: sizer.width(width: 5, context: context),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: sizer.height(height: 4, context: context),
                        width: sizer.width(width: 13, context: context),
                        padding: EdgeInsets.only(
                            bottom: sizer.height(height: .5, context: context)),
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            // border: Border(
                            //   bottom: BorderSide(color: Colors.black, width: 3),
                            // ),
                            ),
                        child: Text(
                          "Apparel",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  sizer.font(fontsize: 12, context: context)),
                        ),
                      ),
                      SizedBox(
                        width: sizer.width(width: 5, context: context),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: sizer.height(height: 4, context: context),
                        width: sizer.width(width: 46, context: context),
                        padding: EdgeInsets.only(
                            bottom: sizer.height(height: .5, context: context)),
                        decoration: BoxDecoration(
                            // color: Colors.red,
                            // border: Border(
                            //     bottom:
                            //         BorderSide(color: Colors.black, width: 3)),
                            ),
                        child: Text(
                          "Luggage, Badge & Cases",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  sizer.font(fontsize: 12, context: context)),
                        ),
                      ),
                      SizedBox(
                        width: sizer.width(width: 1, context: context),
                      ),
                      Container(
                          alignment: Alignment.center,
                          height: sizer.height(height: 4, context: context),
                          padding: EdgeInsets.only(
                              bottom:
                                  sizer.height(height: .5, context: context)),
                          child: Icon(Icons.more_horiz_outlined))
                    ],
                  ),
                ),
                SizedBox(
                  height: sizer.height(height: 1.8, context: context),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 5, context: context),
                  ),
                  child: Container(
                    height: sizer.height(height: 15, context: context),
                    width: sizer.width(width: 100, context: context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://tse1.mm.bing.net/th?id=OIP.23JncAVbMTn_hxZ6Jyo9hwHaEE&pid=Api&P=0&w=286&h=157"))),
                  ),
                ),
                SizedBox(height: sizer.height(height: 3, context: context)),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 3, context: context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Best Seller",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 12, context: context)),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: sizer.font(fontsize: 20, context: context),
                      )
                    ],
                  ),
                ),
                SizedBox(height: sizer.height(height: 1, context: context)),
                Container(
                  // color: Colors.red,
                  height: sizer.height(height: 20, context: context),
                  width: sizer.width(width: 100, context: context),
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 5, context: context),
                  ),
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.bestSeller.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: sizer.width(width: 3, context: context)),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    sizer.height(height: 16, context: context),
                                width: sizer.width(width: 35, context: context),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller
                                            .bestSeller[index]['image']))),
                              ),
                              SizedBox(
                                  height: sizer.height(
                                      height: 1, context: context)),
                              Container(
                                alignment: Alignment.center,
                                width: sizer.width(width: 35, context: context),
                                child: Text(
                                  controller.bestSeller[index]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF4F4F4F),
                                      fontSize: sizer.font(
                                          fontsize: 9, context: context)),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: sizer.height(height: 1, context: context)),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 3, context: context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Best Deals",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 12, context: context)),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: sizer.font(fontsize: 20, context: context),
                      )
                    ],
                  ),
                ),
                SizedBox(height: sizer.height(height: 1, context: context)),
                Container(
                  // color: Colors.red,
                  height: sizer.height(height: 20, context: context),
                  width: sizer.width(width: 100, context: context),
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 2, context: context),
                    right: sizer.width(width: 4, context: context),
                  ),
                  child: Obx(
                    () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.bestDeals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: sizer.width(width: 3, context: context)),
                          child: Column(
                            children: [
                              Container(
                                height:
                                    sizer.height(height: 16, context: context),
                                width: sizer.width(width: 35, context: context),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(controller
                                            .bestDeals[index]['image']))),
                              ),
                              SizedBox(
                                  height: sizer.height(
                                      height: 1, context: context)),
                              Container(
                                width: sizer.width(width: 35, context: context),
                                alignment: Alignment.center,
                                child: Text(
                                  controller.bestDeals[index]["name"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF4F4F4F),
                                      fontSize: sizer.font(
                                          fontsize: 9, context: context)),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: sizer.height(height: 1, context: context)),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 5, context: context),
                    right: sizer.width(width: 3, context: context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Apparels",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                sizer.font(fontsize: 12, context: context)),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: sizer.font(fontsize: 20, context: context),
                      )
                    ],
                  ),
                ),
                SizedBox(height: sizer.height(height: 1, context: context)),
                Container(
                  padding: EdgeInsets.only(
                    left: sizer.width(width: 3, context: context),
                    right: sizer.width(width: 2.5, context: context),
                  ),
                  height: sizer.height(height: 30, context: context),
                  width: sizer.width(width: 100, context: context),
                  child: Obx(
                    () => GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.25),
                      children: controller.apparels
                          .map((data) => GestureDetector(
                              onTap: () {},
                              child: Container(
                                  margin: EdgeInsets.only(
                                      right: sizer.width(
                                          width: 1.6, context: context),
                                      left: sizer.width(
                                          width: 1.6, context: context)),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.black12),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: sizer.height(
                                            height: 20, context: context),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    data['image']))),
                                      ),
                                      SizedBox(
                                          height: sizer.height(
                                              height: 1, context: context)),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: sizer.width(
                                              width: 2, context: context),
                                        ),
                                        child: Text(
                                          data['name'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF4F4F4F),
                                              fontSize: sizer.font(
                                                  fontsize: 9,
                                                  context: context)),
                                        ),
                                      ),
                                      SizedBox(
                                          height: sizer.height(
                                              height: 0.5, context: context)),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: sizer.width(
                                              width: 2, context: context),
                                        ),
                                        child: Text(
                                          data['price'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF000000),
                                              fontSize: sizer.font(
                                                  fontsize: 10,
                                                  context: context)),
                                        ),
                                      ),
                                    ],
                                  ))))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          color: Colors.white60,
          height: sizer.height(height: 8, context: context),
          width: sizer.width(width: 100, context: context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.redAccent,
                    ),
                    Text("Home",
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 11, context: context),
                            color: Color(0xFFff0000)))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.message),
                    Text(
                      "Message",
                      style: TextStyle(
                          fontSize: sizer.font(fontsize: 11, context: context),
                          color: Color(0xFF000000)),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long),
                    Text("Purchase",
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 11, context: context),
                            color: Color(0xFF000000)))
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    Text("Account",
                        style: TextStyle(
                            fontSize:
                                sizer.font(fontsize: 11, context: context),
                            color: Color(0xFF000000)))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
