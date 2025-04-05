import 'package:flutter/material.dart';
import 'widgets/onboarding_screen_widget.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Podkes Case Study',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnboardingScreenWidget(),
    );
  }
}
