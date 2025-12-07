import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';

class ProfileViewHeader extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProfileViewHeader({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<String>(
        icon: const Icon(Icons.more_vert, color: AppColors.gray500),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        offset: const Offset(-10, 28),
        constraints: const BoxConstraints(minWidth: 200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onSelected: (value) {
          if (value == 'edit') {
            onEdit();
          } else if (value == 'delete') {
            onDelete();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'edit',
            height: 36,
            child: Row(
              children: [
                Text(
                  'Edit',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/edit.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuItem(
            enabled: false,
            height: 1,
            padding: EdgeInsets.zero,
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade200,
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            height: 36,
            child: Row(
              children: [
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/icons/delete.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
