import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';

class SaveToDeviceButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback? onPressed;

  const SaveToDeviceButton({super.key, required this.isSaved, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 54,
          child: OutlinedButton.icon(
            onPressed: isSaved ? null : onPressed,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              side: BorderSide(
                color: isSaved ? AppColors.gray200 : AppColors.textPrimary,
              ),
              foregroundColor: isSaved
                  ? AppColors.gray300
                  : AppColors.textPrimary,
              disabledForegroundColor: AppColors.gray300,
            ),
            icon: SvgPicture.asset(
              'assets/icons/save.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                isSaved ? AppColors.gray300 : AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
            label: const Text(
              'Save to My Phone Contact',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        if (isSaved)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/info.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.gray500,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'This contact is already saved your phone.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.gray500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
