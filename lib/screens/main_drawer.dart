import 'package:flutter/material.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            color: Theme.of(context).colorScheme.secondary,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
            context,
            Icons.restaurant,
            'Meals',
            MyApp.routeName,
          ),
          buildListTile(
            context,
            Icons.settings,
            'Filters',
            FiltersScreen.routeName,
          ),
        ],
      ),
    );
  }

  ListTile buildListTile(BuildContext context, icon, title, routename) {
    return ListTile(
      onTap: () => Navigator.of(context).pushReplacementNamed(routename),
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }
}
