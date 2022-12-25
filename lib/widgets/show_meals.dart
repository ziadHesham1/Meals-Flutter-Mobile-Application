import 'package:flutter/material.dart';

import '../models/meal.dart';
import 'meal_item.dart';

class ShowMeals extends StatelessWidget {
  const ShowMeals(this.categoryMeals, {Key? key}) : super(key: key);

  final List<Meal> categoryMeals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: ((context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            duration: categoryMeals[index].duration,
            imgUrl: categoryMeals[index].imageUrl,
            complexity: categoryMeals[index].complexity,
            affordability: categoryMeals[index].affordability,
          );
        }),
      ),
    );
  }
}
