import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Discounts/Discount_model.dart';

import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class DiscountApi {
// Future<List<Bus>>
  static Future add_Discount({
    required String discountname,
    required String discountvalue,
    required String discounttype,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-discount.php"),
        body: {
          'discount_name': discountname,
          'discount': discountvalue,
          'discount_type': discounttype,
          'discount_creator_id': Get.find<StorageService>().box.read('userid'),
          'discount_store_id':
              Get.find<StorageService>().box.read('storeid').toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(response.body);
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
      print('add_Discount catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<Discount>> get_All_Discount() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-discountss.php"),
        body: {
          'discount_store_id':
              await Get.find<StorageService>().box.read('storeid').toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return discountFromJson(
              jsonEncode(jsonDecode(response.body)['data']));
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_All_Discount catch error $error');
      return Future.error(true);
    }
  }

  static Future delete_discount({
    required int discountid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-discount.php"),
        body: {
          'discountid': discountid.toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(response.body);
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
      print('delete_discount catch error $error');
      return Future.error(true);
    }
  }

  static Future update_Discount({
    required String discountid,
    required String discount,
    required String discounttype,
    required String discountname,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-discount.php"),
        body: {
          'discountid': discountid.toString(),
          'discount': discount.toString(),
          'discounttype': discounttype.toString(),
          'discountname': discountname.toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(response.body);
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
      print('delete_discount catch error $error');
      return Future.error(true);
    }
  }

  static Future samples() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/sample1.php"),
        body: {},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(response.body);
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
      print('samples catch error $error');
      return Future.error(true);
    }
  }
}
