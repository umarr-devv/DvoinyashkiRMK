import 'package:app/utils/debounce_notifier.dart';
import 'package:flutter/material.dart';

final productSeachQuery = ValueNotifier<String>('');
final productSeachQueryDebounce = DebouncedNotifier<String>(
  notifier: productSeachQuery,
);
