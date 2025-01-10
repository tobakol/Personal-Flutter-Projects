// ignore_for_file: constant_identifier_names

enum Complexity {
  Simple('Simple'),
  Challenging('Challenging'),
  Hard('Hard'),
  ;

  final String value;
  const Complexity(this.value);
}

enum Affordability {
  Affordable('Affordable'),
  Pricey('Pricey'),
  Luxurious('Expensive');

  final String value;
  const Affordability(this.value);
}

class Meal {
  final String id;
  final String title;
  final List<String> categories;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  //final Complexity complexity;
  // final Affordability affordability;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal(
      {required this.id,
      required this.categories,
      required this.imageUrl,
      required this.ingredients,
      required this.steps,
      required this.duration,
      // required this.complexity,
      // required this.affordability,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian,
      required this.title});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json["id"],
      categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
      title: json["title"],
      //  affordability: json["affordability"],
      //  complexity: json["complexity"],
      imageUrl: json["imageUrl"],
      duration: json["duration"],
      ingredients: json["ingredients"] == null ? [] : List<String>.from(json["ingredients"]!.map((x) => x)),
      steps: json["steps"] == null ? [] : List<String>.from(json["steps"]!.map((x) => x)),
      isGlutenFree: json["isGlutenFree"],
      isVegan: json["isVegan"],
      isVegetarian: json["isVegetarian"],
      isLactoseFree: json["isLactoseFree"],
    );
  }
}
