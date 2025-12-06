import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessAnimationScreen extends StatelessWidget {
  const SuccessAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/Done.json',
              width: 150,
              height: 150,
              fit: BoxFit.fill,
              repeat: false,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**', 'Fill 1', '**'],
                    value: const Color(0xFF12B76A),
                  ),
                  ValueDelegate.color(
                    const ['**', 'Stroke 1', '**'],
                    value: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'All Done!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'New contact saved 🎉',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
