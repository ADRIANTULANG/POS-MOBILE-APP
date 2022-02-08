import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  //Instance of get storage
  final box = GetStorage();

  storeusers({
    required String usertype,
    required String userid,
    required String username,
    required String password,
    required String storeid,
  }) {
    box.write('usertype', usertype);
    box.write('userid', userid);
    box.write('userlogin', username);
    box.write('password', password);
    box.write('storeid', storeid);

    // imagess.value = box.read('userImage');
  }

  removeUsers() {
    box.remove('usertype');
    box.remove('userid');
    box.remove('userlogin');
    box.remove('password');
    box.remove('storeid');

    // imagess = ''.obs;
  }

// for items homepage display and discount below methods
  setOfflineItems({required List<dynamic> listofitems}) {
    box.write('listofitems', listofitems);
    print("items saved to local");
  }

  setOfflineDiscounts({required List<dynamic> listofdiscounts}) {
    box.write('listofdiscounts', listofdiscounts);
    print("discount saved to local");
  }

  // for history below methods

  saveOfflineItems({required List<dynamic> listofordereditems}) {
    if (box.read('listofordereditems') == null) {
      box.write('listofordereditems', listofordereditems);
    } else {
      List list = box.read('listofordereditems');
      for (var i = 0; i < listofordereditems.length; i++) {
        list.add(listofordereditems[i]);
      }
      box.write('listofordereditems', list);
    }
  }

  setOrderID({required int id}) {
    box.write('orderid', id);
  }

  setOrderHistory({required List<dynamic> orderhistory}) {
    if (box.read('orderhistory') == null) {
      box.write('orderhistory', orderhistory);
    } else {
      List list = box.read('orderhistory');
      for (var i = 0; i < orderhistory.length; i++) {
        list.add(orderhistory[i]);
      }
      box.write('orderhistory', list);
    }
  }
}
