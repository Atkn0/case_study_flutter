import 'package:flutter/material.dart';

class OnboardingBottomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const OnboardingBottomButton({Key? key, required this.onPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.all(12),
          minimumSize: const Size(60, 60),
        ),
        child: const Icon(Icons.arrow_forward, color: Color(0xFF525298)),
      ),
    );
  }
}
