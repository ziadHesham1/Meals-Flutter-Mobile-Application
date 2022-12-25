import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/show_meals.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen(this.availableMeals, {super.key});
  @override
  Widget build(BuildContext context) {
    /* getting route argument from the category item
    contains the category title and its id */
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    var categoryTitle = routeArgs['title'] ?? '';
    var categoryId = routeArgs['id'] ?? '';
    var categoryMeals = availableMeals.where(
      (mealsElement) {
        return mealsElement.categories.contains(categoryId);
      },
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
        ),
      ),
      body: ShowMeals(categoryMeals),
    );
  }
}
