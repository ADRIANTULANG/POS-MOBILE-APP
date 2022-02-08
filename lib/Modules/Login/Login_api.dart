import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Login/Login_model.dart';
import 'package:mobilepos/helpers/endpoints.dart';

class LoginApi {
// Future<List<Bus>>
  static Future<List<Userdata>> get_user({
    required String username,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-user.php"),
        body: {'username': username, 'password': password},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          print(result);
          return userdataFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_user catch error $error');
      return Future.error(true);
    }
  }
}
