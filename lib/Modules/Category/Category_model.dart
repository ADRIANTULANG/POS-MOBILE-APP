import 'dart:convert';

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    required this.categoryId,
    required this.categoryName,
    required this.categoryStoreId,
  });

  int categoryId;
  String categoryName;
  int categoryStoreId;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categoryId: json["Category_id"],
        categoryName: json["Category_name"],
        categoryStoreId: json["Category_Store_id"],
      );

  Map<String, dynamic> toJson() => {
        "Category_id": categoryId,
        "Category_name": categoryName,
        "Category_Store_id": categoryStoreId,
      };
}
