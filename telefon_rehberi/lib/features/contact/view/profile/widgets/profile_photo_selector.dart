import 'dart:io';
import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'package:telefon_rehberi/core/widgets/avatar_glow.dart';

class ProfilePhotoSelector extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;

  const ProfilePhotoSelector({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AvatarGlow(
            imagePath: imagePath,
            size: 120,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.gray200,
                image: imagePath != null
                    ? DecorationImage(
                        image: imagePath!.startsWith('http')
                            ? NetworkImage(imagePath!) as ImageProvider
                            : FileImage(File(imagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imagePath == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Change Photo',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
