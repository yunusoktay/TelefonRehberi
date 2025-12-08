import 'dart:io';
import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'package:telefon_rehberi/core/widgets/avatar_glow.dart';

class PhotoSelector extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onTap;

  const PhotoSelector({
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
                color: AppColors.avatarPlaceholder,
                shape: BoxShape.circle,
                image: imagePath != null
                    ? DecorationImage(
                        image: FileImage(File(imagePath!)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: imagePath == null
                  ? Center(
                      child: Icon(
                        Icons.person,
                        size: 100,
                        color: AppColors.inputBackground,
                      ),
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Add Photo',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
