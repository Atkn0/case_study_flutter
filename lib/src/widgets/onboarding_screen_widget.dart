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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Onboarding Page ${onboardingVM.currentPage + 1}'),
            ElevatedButton(
              onPressed: () {
                if (onboardingVM.currentPage < onboardingVM.totalPages - 1) {
                  onboardingVM.currentPage++;
                  onboardingVM.notifyListeners();
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
            ElevatedButton(
              onPressed: () {
                onboardingVM.onSkip();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenWidget()),
                );
              },
              child: Text('Skip'),
            ),
          ],
        ),
      ),
    );
  }
}
