import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Category/Category_model.dart';

import 'package:mobilepos/helpers/endpoints.dart';

class CategoryApi {
// Future<List<Bus>>
  static Future add_Category_api({
    required String categoryname,
    required String storeid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/add-category.php"),
        body: {'categoryname': categoryname, 'storeid': storeid},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(json.encode(json.decode(response.body)));
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
      print('get_user catch error $error');
      return Future.error(true);
    }
  }

  static Future deleteCat({
    required String categoryid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-categories.php"),
        body: {'categoryid': categoryid},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(json.encode(json.decode(response.body)));
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
      print('deleteCat catch error $error');
      return Future.error(true);
    }
  }

  static Future updateCat(
      {required String categoryid, required String categoryname}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-categories.php"),
        body: {'categoryid': categoryid, 'categoryname': categoryname},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(json.encode(json.decode(response.body)));
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
      print('updateCat catch error $error');
      return Future.error(true);
    }
  }

// <List<Bus>>
  static Future<List<Categories>> get_all_Categories({
    required String storeid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-categories.php"),
        body: {'storeid': storeid},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var data = jsonEncode(jsonDecode(response.body)['data']);
          return categoriesFromJson(data);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_all_Categories catch error $error');
      return Future.error(true);
    }
  }
}
