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

final allSelectedCategory = SelectedCategoryData(all: true);

final favoriteSelectedCategory = SelectedCategoryData(favorite: true);

final selectedCategory = ValueNotifier<SelectedCategoryData>(
  allSelectedCategory,
);
