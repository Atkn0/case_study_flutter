import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'home_screen_widget.dart';

class OnboardingScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onboardingVM = Provider.of<OnboardingViewModel>(context);
    return Scaffold(
      backgroundColor: const Color(0xFF1F1D2B),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: PageView(
              controller: onboardingVM.pageController,
              onPageChanged: onboardingVM.onPageChanged,
              children: [
                Container(
                  color: Color(0xFF1E1E1E),
                  child: Center(
                    child: Image.asset(
                      'assets/images/onboarding_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFF1E1E1E),
                  child: Center(
                    child: Image.asset(
                      'assets/images/onboarding_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  color: Color(0xFF1E1E1E),
                  child: Center(
                    child: Image.asset(
                      'assets/images/onboarding_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Podkes',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                SizedBox(height: 8),
                Text(
                  'Your daily podcast companion',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: DotsIndicator(
              dotsCount: onboardingVM.totalPages,
              position: onboardingVM.currentIndex.toDouble(),
              decorator: DotsDecorator(
                activeColor: Colors.white,
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
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {
                  if (onboardingVM.currentIndex < onboardingVM.totalPages - 1) {
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
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: EdgeInsets.all(12),
                  minimumSize: Size(60, 60),
                ),
                child: Icon(Icons.arrow_forward, color: Color(0xFF525298)),
              ),
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}
