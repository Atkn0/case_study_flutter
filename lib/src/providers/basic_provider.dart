import 'package:flutter/material.dart';

class BasicProvider extends ChangeNotifier {
  int counter = 0;
  void increment() {
    counter++;
    notifyListeners();
  }
}
