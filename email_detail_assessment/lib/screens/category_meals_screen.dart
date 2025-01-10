import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';
import '../providers/meals_list_provider.dart';
import '../utilities/meal_item.dart';

class CategoryMealsScreen extends ConsumerStatefulWidget {
  static const routeName = "/category-meals-screen";

  @override
  ConsumerState<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends ConsumerState<CategoryMealsScreen> {
  // const CategoryMealsScreen(

  @override
  Widget build(BuildContext context) {
    final mealItemList = ref.read(mealItemsProvider);
    return Scaffold(
        //appBar: AppBar(title: Text(categoryTitle)),
        body: ListView.builder(
      itemBuilder: (context, index) {
        return MealItem(
          mealItem: mealItemList[index],
        );
      },
      itemCount: mealItemList.length,
    ));
  }
}
