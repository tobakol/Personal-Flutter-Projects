import 'dart:ui';

import 'package:forms_challenge/data/categories.dart';

class Category {
  final String? categoryName;
  final Color? categoryColor;
  Category(this.categoryName, this.categoryColor);
}

Category categoryFromMap(int index) {
  return categories.entries.toList()[index].value;
}

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other;

  static Category getCategoryFromTitle(String categoryTitle) {
    switch (categoryTitle) {
      case 'Vegetables':
        return categoryFromMap(0);
      case 'Fruit':
        return categoryFromMap(1);
      case 'Meat':
        return categoryFromMap(2);
      case 'Dairy':
        return categoryFromMap(3);
      case 'Carbs':
        return categoryFromMap(4);
      case 'Sweets':
        return categoryFromMap(5);
      case 'Spices':
        return categoryFromMap(6);
      case 'Convenience':
        return categoryFromMap(7);
      case 'Hygiene':
        return categoryFromMap(8);
      case 'Other':
      default:
        return categoryFromMap(9);
    }
  }
}
