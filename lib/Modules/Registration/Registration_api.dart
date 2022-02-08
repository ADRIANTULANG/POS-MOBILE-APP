import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class RegistrationApi {
// Future<List<Bus>>
  static Future create_account({
    required String username,
    required String password,
    required String usertype,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/create-user.php"),
        body: {
          'username': username,
          'password': password,
          "usertype": usertype,
          'storeid': Get.find<StorageService>().box.read('storeid')
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)['success'];
        if (res == true) {
          return true;
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('create_account catch error $error');
      return Future.error(true);
    }
  }

  static Future check_if_account_exist({
    required String username,
    required String password,
    required String usertype,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/check-user.php"),
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body)['success'];
        if (res == true) {
          List data = [];
          data = jsonDecode(response.body)['data'];
          print(data);
          if (data.length == 0) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('check_if_account_exist catch error $error');
      return Future.error(true);
    }
  }
}
