import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Transaction_Details/Transaction_Details_model.dart';
import 'package:mobilepos/helpers/endpoints.dart';

class TransactionDetailsApi {
// Future<List<TransactionDetails>>
  static Future<List<TransactionDetails>> get_History_items(
      {required String ordernumber}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-history-items.php"),
        body: {
          'ordernumber': ordernumber,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);

          return transactionDetailsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_History_items catch error $error');
      return Future.error(true);
    }
  }

// Future<List<InstallmentDetails>>
  static Future<List<InstallmentDetails>> get_installment_Details(
      {required String ordernumber}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-history-items-installment-details.php"),
        body: {
          'ordernumber': ordernumber,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // print(result);
          return installmentDetailsFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_installment_Details catch error $error');
      return Future.error(true);
    }
  }

// Future<List<ItemDetailsForRefund>>
  static Future<List<ItemDetailsForRefund>> getitemDetails(
      {required String itemid}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-items-for-refund.php"),
        body: {
          'itemid': itemid,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // print(result);
          return itemDetailsForRefundFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getitemDetails catch error $error');
      return Future.error(true);
    }
  }

//
  static Future<List<VariantDetailsForRefund>> getVariantDetails(
      {required String variantID}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-variants-for-refund.php"),
        body: {
          'variantid': variantID,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          // print(result);
          return variantDetailsForRefundFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('getVariantDetails catch error $error');
      return Future.error(true);
    }
  }

  static update_and_Delete_item(
      {required String itemid,
      required String ordernumber,
      required String updatedItemCount}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-item-and-delete-orderitem-for-refund.php"),
        body: {
          'itemid': itemid,
          'ordernumber': ordernumber,
          'updateditemcount': updatedItemCount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          print(result);
          // return variantDetailsForRefundFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_and_Delete_item catch error $error');
      return Future.error(true);
    }
  }

  static update_and_Delete_variant(
      {required String itemid,
      required String variantid,
      required String ordernumber,
      required String updatedVariantCount}) async {
    try {
      var response = await http.post(
        Uri.parse(
            "$endPoint/update-variant-and delete-variant-with-orderitem.php"),
        body: {
          'itemid': itemid,
          'variantid': variantid,
          'ordernumber': ordernumber,
          'updatedvariantcount': updatedVariantCount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          print(result);
          // return variantDetailsForRefundFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_and_Delete_variant catch error $error');
      return Future.error(true);
    }
  }

  static update_total_amount_of_ordernumber_total_discount(
      {required String ordernumber,
      required String totalAmount,
      required String totalDiscount}) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-ordernumber-totalAmount.php"),
        body: {
          'ordernumber': ordernumber,
          'totalDiscount': totalDiscount,
          'totalAmount': totalAmount,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var result = jsonEncode(jsonDecode(response.body)['data']);
          print(result);
          // return variantDetailsForRefundFromJson(result);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_total_amount_of_ordernumber catch error $error');
      return Future.error(true);
    }
  }

  static delete_order_number({
    required String ordernumber,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-ordernumber-after-refund.php"),
        body: {
          'ordernumber': ordernumber,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return "Success";
        } else {
          return "Error";
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('delete_order_number catch error $error');
      return Future.error(true);
    }
  }
}
