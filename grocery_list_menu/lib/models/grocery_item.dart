import 'category.dart';

class GroceryItem {
  String? id;
  String name;
  int quantity;
  Category category;

  GroceryItem({this.id, required this.name, required this.quantity, required this.category});

  factory GroceryItem.fromJson(Map<String, Map<String, dynamic>> json) {
    return GroceryItem(
        id: json.keys.first,
        name: json.values.first["name"],
        quantity: json.values.first["quantity"],
        category: Categories.getCategoryFromTitle(json.values.first["category"]));
  }

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name, "quantity": quantity, "category": category.categoryName
      };
}
