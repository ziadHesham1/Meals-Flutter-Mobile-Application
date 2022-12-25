import 'package:flutter/material.dart';
import 'package:meals_app/models/filters.dart';
import 'package:meals_app/screens/main_drawer.dart';

import '../models/meal.dart';

class FiltersScreen extends StatefulWidget {
  static String routeName = '/filters_routeName';
  final Function saveFilters;
  final Filters currentFilters;
  // final Function(Filters filters) saveFilters;
  final List<Meal> availableMeals;
  const FiltersScreen(
      {super.key,
      required this.saveFilters,
      required this.availableMeals,
      required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters.gluten;
    _lactoseFree = widget.currentFilters.lactose;
    _vegetarian = widget.currentFilters.vegetarian;
    _vegan = widget.currentFilters.vegan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                widget.saveFilters(
                  Filters(
                      gluten: _glutenFree,
                      lactose: _lactoseFree,
                      vegan: _vegan,
                      vegetarian: _vegetarian),
                );
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                builderListTile('Gluten-free', 'Only include gluten-free meals',
                    _glutenFree, (value) {
                  setState(() {
                    _glutenFree = value;
                  });
                }),
                builderListTile('Lactose-free',
                    'Only include lactose free meals', _lactoseFree, (value) {
                  setState(() {
                    _lactoseFree = value;
                  });
                }),
                builderListTile(
                    'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                    (value) {
                  setState(() {
                    _vegetarian = value;
                  });
                }),
                builderListTile('vegan', 'Only include vegan meals', _vegan,
                    (value) {
                  setState(() {
                    _vegan = value;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile builderListTile(title, description, boolValue, fn) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: boolValue,
      onChanged: fn,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }
}
