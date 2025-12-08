import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';

class AddContactHeader extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final bool canSave;

  const AddContactHeader({
    super.key,
    required this.onCancel,
    required this.onSave,
    required this.canSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 36, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onCancel,
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontSize: 17,
              ),
            ),
          ),
          Text('New Contact', style: AppTextStyles.headline),
          GestureDetector(
            onTap: canSave ? onSave : null,
            child: Text(
              'Done',
              style: AppTextStyles.bodyMedium.copyWith(
                color: canSave ? AppColors.primary : AppColors.textSecondary,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
