import 'package:email_detail_assessment/utilities/widgets_extensions.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/meal_details_screen.dart';

class MealItem extends StatelessWidget {
  final Meal mealItem;
  const MealItem({super.key, required this.mealItem});

  void selectedMeal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MealDetailScreen(
                selectedMeal: mealItem,
                //email: widget.email,
              )),
    );
  }
//  const MealItem({super.key});
  // String get complexityText {
  //   switch (complexity) {
  //     case Complexity.Simple:
  //       return 'Simple';
  //     case Complexity.Challenging:
  //       return 'Challenging';
  //     case Complexity.Hard:
  //       return 'Hard';
  //       break;
  //     default:
  //       return "Unknown";
  //   }
  // }

  // String get affordabilityText {
  //   switch (affordability) {
  //     case Affordability.Affordable:
  //       return 'Affordable';
  //     case Affordability.Pricey:
  //       return 'Pricey';
  //     case Affordability.Luxurious:
  //       return 'Expensive';
  //       break;
  //     default:
  //       return "Unknown";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectedMeal(context),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  child: Image.network(
                    mealItem.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    color: Colors.black54,
                    child: Text(
                      mealItem.title,
                      style: const TextStyle(fontSize: 26, color: Colors.white),
                      overflow: TextOverflow.fade,
                      softWrap: true,
                    ).spaceSymmetrically(vertical: 5, horizontal: 20),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [const Icon(Icons.schedule).spaceTo(right: 6), Text("${mealItem.duration} min")],
                ),
                // Row(
                //   children: [const Icon(Icons.work).spaceTo(right: 6), Text(complexity.value)],
                // ),
                // Row(
                //   children: [const Icon(Icons.attach_money).spaceTo(right: 6), Text(affordability.value)],
                // ),
              ],
            ).paddingAll(24)
          ],
        ),
      ),
    );
  }
}
