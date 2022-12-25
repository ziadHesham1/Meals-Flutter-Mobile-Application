import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/show_meals.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = '/favorites route';

  final List<Meal> _favoriteMeals;
  const FavoritesScreen(this._favoriteMeals, {super.key});
  @override
  Widget build(BuildContext context) {
    return ShowMeals(_favoriteMeals);
  }
}
