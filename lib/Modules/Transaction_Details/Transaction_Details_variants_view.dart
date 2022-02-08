import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_model.dart';
import 'package:mobilepos/helpers/sizer.dart';

class ViewVariants extends StatelessWidget {
  const ViewVariants({Key? key, required this.variantList}) : super(key: key);
  final RxList<ItemListOfVariantHistory> variantList;
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
          "VARIANTS DETAILS",
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
        child: ListView.builder(
          itemCount: variantList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Obx(
                () => Checkbox(
                  value: variantList[index].variantBoolean.value,
                  activeColor: Colors.blueAccent,
                  onChanged: (bool? value) {
                    if (variantList[index].variantBoolean.value == false) {
                      variantList[index].variantBoolean.value = true;
                    } else {
                      variantList[index].variantBoolean.value = false;
                    }
                    print(variantList[index].variantBoolean.value);
                  },
                ),
              ),
              title: Text(variantList[index].variantName),
              subtitle: Text((variantList[index].variantQuantity *
                          double.parse(variantList[index].variantPrice))
                      .toStringAsFixed(1) +
                  " Php."),
            );
          },
        ),
      ),
    );
  }
}
