import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';

class PhotoSelectionSheet extends StatelessWidget {
  final Function(ImageSource) onImageSourceSelected;

  const PhotoSelectionSheet({super.key, required this.onImageSourceSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCapsuleButton(
            context,
            title: 'Camera',
            icon: SvgPicture.asset(
              'assets/icons/camera.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => onImageSourceSelected(ImageSource.camera),
          ),
          const SizedBox(height: 8),
          _buildCapsuleButton(
            context,
            title: 'Gallery',
            icon: SvgPicture.asset(
              'assets/icons/gallery.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
            onTap: () => onImageSourceSelected(ImageSource.gallery),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
            child: Text(
              'Cancel',
              style: AppTextStyles.titleMediumSemiBold.copyWith(
                color: AppColors.primary,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCapsuleButton(
    BuildContext context, {
    required String title,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
          onTap();
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.textPrimary, width: 1),
          shape: const StadiumBorder(),
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTextStyles.titleMediumSemiBold.copyWith(
                fontSize: 18,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
