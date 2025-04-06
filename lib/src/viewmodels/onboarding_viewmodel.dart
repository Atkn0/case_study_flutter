import 'package:flutter/material.dart';
import '../models/onboarding_item.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<OnboardingItem> onboardingItems = const [
    OnboardingItem(
      image: 'assets/images/first.png',
      title: 'Welcome to Podkes',
      subtitle: 'Discover trending podcasts every day',
    ),
    OnboardingItem(
      image: 'assets/images/first.png',
      title: 'Curated Categories',
      subtitle: 'Life, Tech, Comedy and much more',
    ),
    OnboardingItem(
      image: 'assets/images/first.png',
      title: 'Easy Playback',
      subtitle: 'Stream or download your favorite episodes',
    ),
  ];

  int get totalPages => onboardingItems.length;

  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    currentIndex = totalPages - 1;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  void onDone() {
    // ileriye dönük shared preferences gibi şeyler buraya
    notifyListeners();
  }
}
