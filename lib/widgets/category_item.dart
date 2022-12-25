import 'package:flutter/material.dart';
import 'package:meals_app/screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  const CategoryItem(this.id, this.title, this.color, {super.key});

  // the function that calls the category screen
  void selectCategory(ctx) {
    Navigator.of(ctx).pushNamed(
      CategoryMealsScreen.routeName,
      arguments: {'id': id, 'title': title},
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          selectCategory(context);
        },
        // configure the ripple effect`
        // the color of the tapping effect
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ));
  }
}
