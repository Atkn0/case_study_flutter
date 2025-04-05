import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/onboarding_viewmodel.dart';
import 'home_screen_widget.dart';

class OnboardingScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onboardingVM = Provider.of<OnboardingViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Onboarding')),
      body: PageView(
        controller: onboardingVM.pageController,
        onPageChanged: onboardingVM.onPageChanged,
        children: [
          Container(
            color: Colors.redAccent,
            child: Center(child: Text('Onboarding Page 1')),
          ),
          Container(
            color: Colors.greenAccent,
            child: Center(child: Text('Onboarding Page 2')),
          ),
          Container(
            color: Colors.blueAccent,
            child: Center(child: Text('Onboarding Page 3')),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                onboardingVM.skip();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenWidget()),
                );
              },
              child: Text('Skip'),
            ),
            ElevatedButton(
              onPressed: () {
                if (onboardingVM.currentIndex < onboardingVM.totalPages - 1) {
                  onboardingVM.nextPage();
                } else {
                  onboardingVM.onDone();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreenWidget()),
                  );
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
