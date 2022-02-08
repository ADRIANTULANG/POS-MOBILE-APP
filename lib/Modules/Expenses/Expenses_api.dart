import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Expenses/Expenses_model.dart';

import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class ExpensesApi {
// Future<List<Bus>>
  static add_expenses(
      {required String amount,
      required String note,
      required String dateOnly}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/add-expenses.php"),
        body: {
          'dateOnly': dateOnly,
          'amount': amount,
          'note': note,
          'date': DateTime.now().toString(),
          'storeid': Get.find<StorageService>().box.read('storeid')
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return result;
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('add_expenses catch error $error');
      return Future.error(true);
    }
  }

  // Future<List<Expenses>>
  static Future<List<Expenses>> getExpenses() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-expenses.php"),
        body: {'storeid': Get.find<StorageService>().box.read('storeid')},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          return expensesFromJson(result);
          // print(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getExpenses catch error $error');
      return Future.error(true);
    }
  }
}
