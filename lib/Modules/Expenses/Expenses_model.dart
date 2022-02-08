import 'dart:convert';

List<Expenses> expensesFromJson(String str) =>
    List<Expenses>.from(json.decode(str).map((x) => Expenses.fromJson(x)));

String expensesToJson(List<Expenses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Expenses {
  Expenses({
    required this.expensesId,
    required this.expensesAmount,
    required this.expensesNote,
    required this.expensesDateCreated,
    required this.expensesStoreid,
  });

  int expensesId;
  String expensesAmount;
  String expensesNote;
  DateTime expensesDateCreated;
  String expensesStoreid;

  factory Expenses.fromJson(Map<String, dynamic> json) => Expenses(
        expensesId: json["expensesID"],
        expensesAmount: json["expenses_amount"],
        expensesNote: json["expenses_note"],
        expensesDateCreated: DateTime.parse(json["expenses_date_created"]),
        expensesStoreid: json["expenses_storeid"],
      );

  Map<String, dynamic> toJson() => {
        "expensesID": expensesId,
        "expenses_amount": expensesAmount,
        "expenses_note": expensesNote,
        "expenses_date_created": expensesDateCreated.toIso8601String(),
        "expenses_storeid": expensesStoreid,
      };
}
