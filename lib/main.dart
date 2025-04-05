import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/app.dart';
import 'src/providers/basic_provider.dart';
import 'src/viewmodels/onboarding_viewmodel.dart';
import 'src/viewmodels/home_viewmodel.dart';
import 'src/viewmodels/library_viewmodel.dart';
import 'src/viewmodels/now_playing_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BasicProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => LibraryViewModel()),
        ChangeNotifierProvider(create: (_) => NowPlayingViewModel()),
      ],
      child: MyApp(),
    ),
  );
}
