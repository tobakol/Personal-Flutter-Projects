import 'package:email_detail_assessment/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealsListNotifier extends StateNotifier<List<Meal>> {
  MealsListNotifier() : super(<Meal>[]);
  bool editmealItemToList(List<Meal> mealList) {
    final mealItemInList = state.contains(mealList);

    state = [...state, ...mealList];
    return false;
  }
}

final mealItemsProvider = StateNotifierProvider<MealsListNotifier, List<Meal>>((ref) {
  return MealsListNotifier();
});

class MealsProviderService {
  WidgetRef serviceRef;
  MealsProviderService({required this.serviceRef});

  void editPlaceList(List<Meal> mealList) {
    serviceRef.read(mealItemsProvider.notifier).editmealItemToList(mealList);
  }
}
