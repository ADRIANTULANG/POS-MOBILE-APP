// To parse this JSON data, do
//
//     final userdata = userdataFromJson(jsonString);

import 'dart:convert';

List<Userdata> userdataFromJson(String str) =>
    List<Userdata>.from(json.decode(str).map((x) => Userdata.fromJson(x)));

String userdataToJson(List<Userdata> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Userdata {
  Userdata({
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.userType,
    required this.storeId,
  });

  int userId;
  String userEmail;
  String userPassword;
  String userType;
  int storeId;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userType: json["user_type"],
        storeId: json["Store_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_type": userType,
        "Store_id": storeId,
      };
}
