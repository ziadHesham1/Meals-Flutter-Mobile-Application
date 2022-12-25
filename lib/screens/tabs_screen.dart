import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';

import '../models/meal.dart';
import 'main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;
  const TabsScreen(this._favoriteMeals, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

var selectedPageIndex = 0;
// ignore: prefer_typing_uninitialized_variables
var pages;

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    pages = [
      {'page': const CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget._favoriteMeals), 'title': 'Favorites'}
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectPage(index) {
      setState(() {
        selectedPageIndex = index;
      });
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(pages[selectedPageIndex]['title'] as String),
        ),
        drawer: const MainDrawer(),
        body: pages[selectedPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: selectedPageIndex,
          items: const [
            // Categories tab
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: ('Categories'),
            ),
            // Favorites tab
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
