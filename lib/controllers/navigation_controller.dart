import 'package:flutter/material.dart';

class NavigationController {
  static final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  static void updateIndex(int index) {
    currentIndexNotifier.value = index;
  }
}
