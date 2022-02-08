import 'dart:convert';

List<Installment> installmentFromJson(String str) => List<Installment>.from(
    json.decode(str).map((x) => Installment.fromJson(x)));

String installmentToJson(List<Installment> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Installment {
  Installment({
    required this.installmentId,
    required this.installmentPercentValue,
    required this.installmentStoreid,
    required this.installmentIsActive,
  });

  int installmentId;
  String installmentPercentValue;
  int installmentStoreid;
  int installmentIsActive;

  factory Installment.fromJson(Map<String, dynamic> json) => Installment(
        installmentId: json["installment_id"] ?? 0,
        installmentPercentValue: json["installment_percent_value"] ?? "0.0",
        installmentStoreid: json["installment_storeid"] ?? 0,
        installmentIsActive: json["installment_isActive"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "installment_id": installmentId,
        "installment_percent_value": installmentPercentValue,
        "installment_storeid": installmentStoreid,
        "installment_isActive": installmentIsActive,
      };
}
