import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  int currentPage = 0;
  int totalPages = 3;

  void initOnboarding() {
    isLoading = true;
    isLoading = false;
    notifyListeners();
  }

  void onSkip() {
    notifyListeners();
  }

  void onDone() {
    notifyListeners();
  }
}
