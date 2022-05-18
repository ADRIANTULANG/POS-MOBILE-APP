import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Purchasehistory/PurchasedHistory_model.dart';
import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class PurchasedHistoryApi {
// Future<List<Bus>>
  static Future<List<HistoryModel>> get_History_sales() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-history.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString()
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // print("get_History_sales $result");
          return historyModelFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_History_sales catch error $error');
      return Future.error(true);
    }
  }

//Future<List<DailySalesForPrint>>
  static Future<List<DailySalesForPrint>> get_sales_for_print(
      {required String date}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-sales-daily.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
          'date': date
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return dailySalesForPrintFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_sales_for_print catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<DailySalesForPrint>>
      get_sales_total_cost_for_print() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-sales-total-cost.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return dailySalesForPrintFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_sales_for_print catch error $error');
      return Future.error(true);
    }
  }

//  Future<List<ExpensesDaily>>
  static Future<List<ExpensesDaily>> get_daily_expenses(
      {required String date}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-daily-expenses.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
          'date': date
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

          return expensesDailyFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_daily_expenses catch error $error');
      return Future.error(true);
    }
  }

// List<TotalCostMainItems>
  static Future<List<TotalCostMainItems>> getCostMainItems() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-total-cost-main-items.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print("main items: ${json.encode(json.decode(response.body))}");
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

          return totalCostMainItemsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getCostMainItems catch error $error');
      return Future.error(true);
    }
  }

  static Future<List<TotalCostVariants>> getCostVariants() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-total-cost-variants.php"),
        body: {
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      // print(response.body);
      // print("variants: ${json.encode(json.decode(response.body))}");
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // return [];
          return totalCostVariantsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getCostVariants catch error $error');
      return Future.error(true);
    }
  }
}
