import 'dart:async';

import 'package:flutter/material.dart';

class DebouncedNotifier<T> {
  final Duration delay;
  final ValueNotifier<T> notifier;

  Timer? _timer;

  DebouncedNotifier({
    required this.notifier,
    this.delay = const Duration(milliseconds: 400),
  });

  void setValue(T value) {
    _timer?.cancel();
    _timer = Timer(delay, () {
      notifier.value = value;
    });
  }

  void dispose() {
    _timer?.cancel();
    notifier.dispose();
  }
}