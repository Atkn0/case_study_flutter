import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  PageController pageController = PageController();
  int currentIndex = 0;
  int totalPages = 3;

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < totalPages - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void skip() {
    currentIndex = totalPages - 1;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  void onDone() {
    notifyListeners();
  }
}
