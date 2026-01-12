import 'package:app/models/models.dart';
import 'package:flutter/material.dart';

class SelectedCategoryData {
  SelectedCategoryData({
    this.category,
    this.all = false,
    this.favorite = false,
  });
  final CategoryScheme? category;
  final bool all;
  final bool favorite;
}

final defaultSelectedCategory = SelectedCategoryData(all: true);

final selectedCategory = ValueNotifier<SelectedCategoryData>(defaultSelectedCategory);
