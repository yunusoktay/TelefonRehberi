import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.placeholder,
    required this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.textSecondary,
            fontSize: 17,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          isDense: true,
          filled: false,
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.sentences,
        style: AppTextStyles.bodyRegular.copyWith(
          fontSize: 17,
          color: AppColors.textPrimary,
        ),
        cursorColor: const Color(0xFF007AFF),
      ),
    );
  }
}
