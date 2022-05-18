import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Checkout/Checkout_model.dart';
import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class CheckoutApi {
// Future<List<Bus>>
  static Future<List<Installment>> get_installment() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-installment.php"),
        body: {'storeid': Get.find<StorageService>().box.read('storeid')},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return installmentFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_installment catch error $error');
      return Future.error(true);
    }
  }

  static Future add_installment({
    required String ordernumber,
    required String days_of_installment,
    required String installment_percent_value,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-order-installment.php"),
        body: {
          'ordernumber': ordernumber,
          'days_of_installment': days_of_installment,
          'installment_percent_value': installment_percent_value,
          'storeid': Get.find<StorageService>().box.read('storeid')
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('add_installment catch error $error');
      return Future.error(true);
    }
  }

  static Future create_order_purchase_order(
      {required String paymenttype,
      required String currentdateFull,
      required String currentdate,
      required String totalAmount,
      required String totalDiscount,
      required String additional_checkout_discount,
      required String additional_checkout_discount_type}) async {
    print("pamenttype: ${paymenttype}");
    print("currentdateFull ${currentdateFull}");
    print("currentdate: ${currentdate}");
    print("total amount :${totalAmount}");
    print("totaldiscount: ${totalDiscount}");
    print("additional checkout discount: ${additional_checkout_discount}");
    print(
        "addtional_checkout_discount_type: ${additional_checkout_discount_type}");

    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-order.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
          'paymenttype': paymenttype.toString(),
          'additional_checkout_discount':
              additional_checkout_discount.toString(),
          'additional_checkout_discount_type':
              additional_checkout_discount_type.toString(),
          'userid': Get.find<StorageService>().box.read('userid').toString(),
          'date': currentdate.toString(),
          'order_total_amount': totalAmount.toString(),
          'order_total_discount': totalDiscount.toString(),
          'datetime': currentdateFull.toString()
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print("response: ${response.body}");
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];

          return result;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_order_purchase_order catch error $error');
      return Future.error(true);
    }
  }

  static Future save_items(
      {required String ordernumber,
      required String item_id,
      required String item_name,
      required String item_category_id,
      required String item_cost,
      required String item_barcode,
      required String item_price,
      required String item_store_id,
      required String item_has_variants,
      required String item_category_name,
      required String item_image,
      required String item_discount,
      required String item_date_created,
      required String item_discount_type,
      required String item_quantity}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-order-items.php"),
        body: {
          'ordernumber': ordernumber,
          'item_id': item_id,
          'item_name': item_name,
          'item_category_id': item_category_id,
          'item_cost': item_cost,
          'item_barcode': item_barcode,
          'item_price': item_price,
          'item_store_id': Get.find<StorageService>().box.read('storeid'),
          'item_has_variants': item_has_variants,
          'item_category_name': item_category_name,
          'item_image': item_image,
          'item_quantity': item_quantity,
          'item_discount': item_discount,
          'item_discount_type': item_discount_type,
          'item_date_created': item_date_created,

          // 'storeid': Get.find<StorageService>().box.read('storeid'),
          // 'paymenttype': paymenttype,
          // 'userid': Get.find<StorageService>().box.read('userid').toString()
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'][0][''];
          return result;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('save_items catch error $error');
      return Future.error(true);
    }
  }

  static Future save_variants(
      {required String ordernumber,
      required String variant_id,
      required String variant_name,
      required String variant_count,
      required String variant_price,
      required String variant_mainitem_id,
      required String variant_cost,
      required String variant_store_id,
      required String variant_quantity,
      required String variant_date_created,
      required String variant_discount,
      required String variant_discount_type,
      required String lastinsertedID}) async {
    print(ordernumber);
    print(variant_id);
    print(variant_name);
    print(variant_count);
    print(variant_price);
    print(variant_mainitem_id);
    print(variant_cost);
    print(variant_store_id);
    print(variant_quantity);
    print(variant_date_created);
    print(variant_discount);
    print(variant_discount_type);
    print(lastinsertedID);
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-order-variants.php"),
        body: {
          'ordernumber': ordernumber,
          'variant_id': variant_id,
          'variant_name': variant_name,
          'variant_count': variant_count,
          'variant_cost': variant_cost,
          'variant_price': variant_price,
          'variant_mainitem_id': variant_mainitem_id,
          'variant_store_id': variant_store_id,
          'variant_quantity': variant_quantity,
          'variant_discount': variant_discount,
          'variant_discount_type': variant_discount_type,
          'variant_mainitem_orderID': lastinsertedID,
          'variant_date_created': variant_date_created
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];
          return result;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('save_variants catch error $error');
      return Future.error(true);
    }
  }

  static Future update_item_count({
    required String itemid,
    required String updatedCount,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-item-count.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid'),
          'itemid': itemid,
          'updatedCount': updatedCount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];

          return result;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_item_count catch error $error');
      return Future.error(true);
    }
  }

  static Future update_variant_count({
    required String variantID,
    required String updatedVariantCount,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-variant-count.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid'),
          'variantID': variantID,
          'updatedVariantCount': updatedVariantCount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonDecode(response.body)['data'];
          return result;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_variant_count catch error $error');
      return Future.error(true);
    }
  }
}
