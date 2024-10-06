import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forms_challenge/models/grocery_item.dart';

import '../data/dummy_items1.dart';

class GroceryItemsNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryItemsNotifier() : super(groceryItems);

  bool editGroceryItemToList(GroceryItem groceryItem) {
    final groceryItemInList = state.contains(groceryItem);
    if (groceryItemInList) {
      state = state.where((m) => m.id != groceryItem.id).toList();
      return true;
    } else {
      state = [...state, groceryItem];
      return false;
    }
  }
}

final groceryItemsProvider = StateNotifierProvider<GroceryItemsNotifier, List<GroceryItem>>((ref) {
  return GroceryItemsNotifier();
});
