import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'home_screen_widget.dart';

class OnboardingScreenWidget extends StatelessWidget {
  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/first.png',
      'title': 'Welcome to Podkes',
      'subtitle': 'Discover trending podcasts every day',
    },
    {
      'image': 'assets/images/first.png',
      'title': 'Curated Categories',
      'subtitle': 'Life, Tech, Comedy and much more',
    },
    {
      'image': 'assets/images/first.png',
      'title': 'Easy Playback',
      'subtitle': 'Stream or download your favorite episodes',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final onboardingVM = Provider.of<OnboardingViewModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: PageView.builder(
              controller: onboardingVM.pageController,
              onPageChanged: onboardingVM.onPageChanged,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        data['image']!,
                        fit: BoxFit.contain,
                        height: 300,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        data['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        data['subtitle']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: DotsIndicator(
              dotsCount: onboardingData.length,
              position: onboardingVM.currentIndex.toDouble(),
              decorator: DotsDecorator(
                activeColor: Color(0xFF525298),
                color: Colors.white54,
                size: Size(8.0, 8.0),
                activeSize: Size(10.0, 10.0),
                spacing: EdgeInsets.symmetric(horizontal: 4.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  if (onboardingVM.currentIndex < onboardingData.length - 1) {
                    onboardingVM.nextPage();
                  } else {
                    onboardingVM.onDone();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreenWidget(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(12),
                  minimumSize: const Size(60, 60),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Color(0xFF525298),
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }
}
