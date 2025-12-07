import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';

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
                  ValueDelegate.color(const [
                    '**',
                    'Fill 1',
                    '**',
                  ], value: AppColors.greenSuccess),
                  ValueDelegate.color(const [
                    '**',
                    'Stroke 1',
                    '**',
                  ], value: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'All Done!',
              style: AppTextStyles.headline.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              'New contact saved 🎉',
              style: AppTextStyles.bodyMedium.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
