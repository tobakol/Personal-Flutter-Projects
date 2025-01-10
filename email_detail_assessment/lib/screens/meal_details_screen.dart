import 'package:email_detail_assessment/models/meal.dart';
import 'package:flutter/material.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = "/meal-details-screen";
  final Meal selectedMeal;
  const MealDetailScreen({required this.selectedMeal});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final seletedMeal = widget.selectedMeal;
    // final mealDetails = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    //final seletedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealDetails["id"]);
    return Scaffold(
      appBar: AppBar(title: Text(seletedMeal.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                seletedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            titleTag(context, "Ingredients"),
            listCard(
              ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: seletedMeal.ingredients.length,
                  itemBuilder: (context, index) => Card(
                      //color: Theme.of(context).accentColor,
                      child: Text(seletedMeal.ingredients[index]) //.spacingAlongAxis(vertical: 5, horizontal: 10),
                      )),
            ),
            titleTag(context, "Ingredients"),
            listCard(ListView.builder(
                itemCount: seletedMeal.steps.length,
                itemBuilder: (context, index) => Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(child: Text("# ${index + 1}")),
                          title: Text(seletedMeal.steps[index]),
                        ),
                        const Divider(
                          color: Colors.grey,
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Container titleTag(BuildContext context, String titleText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        titleText,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget listCard(Widget child) {
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
        height: 200,
        width: 300,
        child: child);
  }
}
