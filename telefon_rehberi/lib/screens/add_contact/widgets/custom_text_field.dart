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
    return TextField(
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textSecondary,
          fontSize: 17,
        ),
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.inputBorder,
            width: 0.8,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 0.8),
        ),
      ),
      keyboardType: keyboardType,
      onChanged: onChanged,
      textCapitalization: TextCapitalization.sentences,
      style: AppTextStyles.bodyRegular.copyWith(
        fontSize: 17,
        color: AppColors.textPrimary,
      ),
      cursorColor: const Color(0xFF007AFF),
    );
  }
}
