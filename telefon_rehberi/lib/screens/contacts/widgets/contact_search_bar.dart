import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';

class ContactSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  const ContactSearchBar({
    super.key,
    required this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        style: AppTextStyles.bodyRegular.copyWith(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: 'Search by name',
          hintStyle: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.iconColor, size: 22),
          filled: true,
          fillColor: AppColors.cardBackground,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          isDense: true,
        ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        controller: controller,
      ),
    );
  }
}
