import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobilepos/Modules/Category/Category_model.dart';
import 'package:mobilepos/Modules/Items/item_model.dart';

import 'package:mobilepos/helpers/endpoints.dart';
import 'package:mobilepos/helpers/storage.dart';

class itemApi {
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

// <List<Items>>
  static Future<List<ItemsNew>> get_All_items({
    required String storeid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-items.php"),
        body: {'storeid': storeid},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var data = jsonEncode(jsonDecode(response.body)['data']);
          // print(data);
          return ItemsNewFromJson(data);
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

// <List<VariantListInUpdate> >
  static Future<List<VariantListInUpdate>> get_All_Variants({
    required String storeid,
    required String itemId,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/get-variants.php"),
        body: {
          'storeid': storeid,
          'itemId': itemId,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var data = jsonEncode(jsonDecode(response.body)['data']);
          print(data);
          return variantListInUpdateFromJson(data);
        } else {
          return [];
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_All_Variants catch error $error');
      return Future.error(true);
    }
  }

  static Future add_items({
    required String item_name,
    required String item_category_id,
    required String item_cost,
    required String item_barcode,
    required String item_price,
    required String item_count,
    required String item_has_variants,
    required String item_store_id,
    required String item_image,
    required String item_category_name,
    required String item_discount,
    required String item_discount_type,
    required File filepath,
  }) async {
    print(item_name);
    print(item_category_id);
    print(item_cost);
    print(item_barcode);
    print(item_price);
    print(item_count);
    print(item_has_variants);
    print(item_image);
    print(item_category_name);
    print(filepath);
    print(item_discount);
    try {
      var response = await http.post(
        Uri.parse("$endPoint/add-items.php"),
        body: {
          'item_name': item_name,
          'item_category_id': item_category_id,
          'item_cost': item_cost,
          'item_barcode': item_barcode,
          'item_price': item_price,
          'item_count': item_count,
          'item_has_variants': item_has_variants,
          'item_store_id': item_store_id,
          'item_image': item_image,
          'item_category_name': item_category_name,
          'item_discount': item_discount,
          'item_discount_type': item_discount_type
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var itemid = jsonDecode(response.body)['data'][0][""];

          multipartAdd_images(filepath: filepath.path);

          return itemid;
        } else {
          return;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('add_items catch error $error');
      return Future.error(true);
    }
  }

  static Future add_items_no_images({
    required String item_name,
    required String item_category_id,
    required String item_cost,
    required String item_barcode,
    required String item_price,
    required String item_count,
    required String item_has_variants,
    required String item_store_id,
    required String item_image,
    required String item_category_name,
    required String item_discount,
    required String item_discount_type,
  }) async {
    print(item_name);
    print(item_category_id);
    print(item_cost);
    print(item_barcode);
    print(item_price);
    print(item_count);
    print(item_has_variants);
    print(item_image);
    print(item_category_name);

    try {
      var response = await http.post(
        Uri.parse("$endPoint/add-items.php"),
        body: {
          'item_name': item_name,
          'item_category_id': item_category_id,
          'item_cost': item_cost,
          'item_barcode': item_barcode,
          'item_price': item_price,
          'item_count': item_count,
          'item_has_variants': item_has_variants,
          'item_store_id': item_store_id,
          'item_image': item_image,
          'item_category_name': item_category_name,
          'item_discount': item_discount,
          'item_discount_type': item_discount_type
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var itemid = jsonDecode(response.body)['data'][0][""];

          return itemid;
        } else {
          return;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('add_items catch error $error');
      return Future.error(true);
    }
  }

  static multipartAdd_images({
    required String filepath,
  }) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$endPoint/Multipart-Request-SaveImage.php"));
      request.fields['name'] = "image";
      var pic = await http.MultipartFile.fromPath("image", filepath);
      request.files.add(pic);
      var response = await request.send();
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        print("image uploaded success");
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('get_all_Categories catch error $error');
      return Future.error(true);
    }
  }

  static multipartAdd_images_update_images(
      {required String filepath,
      required String filename,
      required String itemid,
      required String item_store_id}) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$endPoint/Multipart-Request-UpdateImage.php"));
      request.fields['name'] = "image";
      request.fields['itemid'] = itemid;
      request.fields['item_store_id'] = item_store_id;
      var pic = await http.MultipartFile.fromPath("image", filepath);
      request.files.add(pic);
      var response = await request.send();
      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        print("image updated success");
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('multipartAdd_images_update_images catch error $error');
      return Future.error(true);
    }
  }

  static Future addVariants({
    required String variant_name,
    required String variant_count,
    required String variant_price,
    required String variant_mainitem_id,
    required String variant_store_id,
    required String variant_discount,
    required String variant_barcode,
    required String variant_discount_type,
  }) async {
    print(variant_name);
    print(variant_count);
    print(variant_price);
    print(variant_mainitem_id);
    print(variant_store_id);
    print(variant_discount);
    print(variant_discount_type);
    print(variant_barcode);
    try {
      var response = await http.post(
        Uri.parse("$endPoint/add-variants.php"),
        body: {
          'variant_barcode': variant_barcode,
          'variant_name': variant_name,
          'variant_count': variant_count,
          'variant_price': variant_price,
          'variant_mainitem_id': variant_mainitem_id,
          'variant_store_id': variant_store_id,
          'variant_discount': variant_discount,
          'variant_discount_type': variant_discount_type,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          return true;
        } else {
          return;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('addVariants catch error $error');
      return Future.error(true);
    }
  }

  static Future delete_items({
    required int itemid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-items.php"),
        body: {'itemid': itemid.toString()},
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var data = jsonEncode(jsonDecode(response.body)['data']);
          // print(data);
          return ItemsNewFromJson(data);
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

  static Future delete_variants({
    required String variantID,
    required String itemid,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$endPoint/delete-variants.php"),
        body: {
          'variantID': variantID.toString(),
          'storeid': Get.find<StorageService>().box.read('storeid').toString(),
          'itemid': itemid
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });

      // print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          var data = jsonEncode(jsonDecode(response.body)['data']);
          // print(data);
          return ItemsNewFromJson(data);
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

  static Future update_items({
    required String item_name,
    required String item_category_id,
    required String item_cost,
    required String item_barcode,
    required String item_price,
    required String item_count,
    required String item_has_variants,
    required String item_store_id,
    required String itemid,
    required String item_category_name,
    required String item_discount,
    required String item_discount_type,
    // required File filepath,
  }) async {
    // print(item_name);
    // print(item_category_id);
    // print(item_cost);
    // print(item_barcode);
    // print(item_price);
    // print(item_count);
    // print(item_has_variants);
    print(itemid);
    print(item_store_id);
    // print(item_category_name);

    try {
      var response = await http.post(
        Uri.parse("$endPoint/update-items.php"),
        body: {
          'item_name': item_name,
          'item_category_id': item_category_id,
          'item_cost': item_cost,
          'item_barcode': item_barcode,
          'item_price': item_price,
          'item_count': item_count,
          'item_has_variants': item_has_variants,
          'item_store_id': item_store_id,
          'itemid': itemid,
          'item_category_name': item_category_name,
          'item_discount': item_discount,
          'item_discount_type': item_discount_type,
        },
      ).timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("timeout");
      });
      print(response.body);
      print(json.encode(json.decode(response.body)));
      if (response.statusCode == 200) {
        var status = jsonDecode(response.body)['success'];
        if (status == true) {
          // var itemid = jsonDecode(response.body)['data'][0][""];
          // multipartAdd_images(filepath: filepath.path);

          return true;
        } else {
          return;
        }
      } else {
        return Future.error(true);
      }
    } catch (error) {
      print('update_items catch error $error');
      return Future.error(true);
    }
  }
}
