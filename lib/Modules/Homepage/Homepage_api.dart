import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Homepage/Homepage_model.dart';

import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class HomepageApi {
// FuFuture<List<ItemsModel>>
  static Future<List<ItemsModel>> get_all_items() async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-items-with-variants.php"),
        body: {'storeid': Get.find<StorageService>().box.read('storeid')},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var data = jsonEncode(jsonDecode(response.body)['data']);
          print(data);
          return itemsModelFromJson(data);
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
