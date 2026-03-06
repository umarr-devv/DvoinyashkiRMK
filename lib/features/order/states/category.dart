import 'package:app/models/group.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SelectedGroupData extends Equatable {
  const SelectedGroupData({
    this.group,
    this.all = false,
    this.favorite = false,
  });
  final GroupScheme? group;
  final bool all;
  final bool favorite;

  @override
  List<Object?> get props => [group, all, favorite];
}

final allSelectedCategory = SelectedGroupData(all: true);

final favoriteSelectedCategory = SelectedGroupData(favorite: true);

final selectedCategory = ValueNotifier<SelectedGroupData>(allSelectedCategory);
