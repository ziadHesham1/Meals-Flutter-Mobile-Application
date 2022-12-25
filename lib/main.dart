import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/filters.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'screens/filters_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  static String routeName = '/';

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
// ------------------ Filters section ---------------------------

  // the meals will be filtered based on this variable
  Filters _filters =
      Filters(gluten: false, lactose: false, vegan: false, vegetarian: false);
  // the meals that will be shown in the app
  // by default it will be all DUMMY_MEALS until some filters are set
  //  then it will be filtered
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilters(Filters filterData) {
    setState(() {
      _filters = filterData;
      // keep the true values of the givin filters only and skip the remaining
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters.gluten && !meal.isGlutenFree) {
          return false;
        }
        if (_filters.lactose && !meal.isLactoseFree) {
          return false;
        }
        if (_filters.vegetarian && !meal.isVegetarian) {
          return false;
        }
        if (_filters.vegan && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }
// ----------- end of filters section ---------------------------

// ---------------- Favorites section ---------------------------
  final List<Meal> _favoriteMeals = [];
  void _toggleFavorite(String mealId) {
    int existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        Meal firstWhere = DUMMY_MEALS.firstWhere(((meal) {
          return meal.id == mealId;
        }));
        _favoriteMeals.add(firstWhere);
      });
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }
// --------- End of Favorites section ---------------------------

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      // routes table
      routes: {
        // Home screen
        MyApp.routeName: ((context) => TabsScreen(_favoriteMeals)),
        // all the meals of a certain category Screen
        CategoryMealsScreen.routeName: ((context) => CategoryMealsScreen(
              _availableMeals,
            )),
        // the details of a certain meal screen
        MealDetailScreen.routeName: ((context) =>
            MealDetailScreen(_toggleFavorite,_isFavorite)),

        FiltersScreen.routeName: (context) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
              availableMeals: _availableMeals,
            ),
      },
      onUnknownRoute: ((settings) {
        return MaterialPageRoute(
            builder: ((context) => const CategoriesScreen()));
      }),
    );
  }
}
