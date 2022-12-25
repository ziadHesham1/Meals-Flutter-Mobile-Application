import 'package:flutter/material.dart';

class MealCategory {
  final String id;
  final String title;
  final Color color;
 const MealCategory({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}
