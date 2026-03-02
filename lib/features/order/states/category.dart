import 'package:app/models/group.dart';
import 'package:flutter/material.dart';

class SelectedGroupData {
  SelectedGroupData({this.group, this.all = false, this.favorite = false});
  final GroupScheme? group;
  final bool all;
  final bool favorite;
}

final allSelectedCategory = SelectedGroupData(all: true);

final favoriteSelectedCategory = SelectedGroupData(favorite: true);

final selectedCategory = ValueNotifier<SelectedGroupData>(allSelectedCategory);
