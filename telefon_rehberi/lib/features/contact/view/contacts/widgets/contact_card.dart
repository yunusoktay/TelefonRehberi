import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'package:telefon_rehberi/core/constants/api_constants.dart';
import '../../../model/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final bool isDeviceContact;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactCard({
    super.key,
    required this.contact,
    this.isDeviceContact = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(contact.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.30,
        children: [
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (context) => onEdit?.call(),
            backgroundColor: AppColors.primaryBlue,
            foregroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/edit.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          CustomSlidableAction(
            padding: EdgeInsets.zero,
            onPressed: (context) => onDelete?.call(),
            backgroundColor: AppColors.redDelete,
            foregroundColor: Colors.white,
            child: SvgPicture.asset(
              'assets/icons/delete.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue50,
                      image: contact.imagePath != null
                          ? DecorationImage(
                              image: _getImageProvider(contact.imagePath!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: contact.imagePath == null
                        ? Center(
                            child: Text(
                              contact.firstName.isNotEmpty
                                  ? contact.firstName[0].toUpperCase()
                                  : '?',
                              style: AppTextStyles.headline.copyWith(
                                color: AppColors.primaryBlue,
                              ),
                            ),
                          )
                        : null,
                  ),
                  if (isDeviceContact)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4),
                        child: SvgPicture.asset(
                          'assets/icons/telephone.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${contact.firstName} ${contact.lastName}',
                      style: AppTextStyles.titleMediumSemiBold,
                    ),
                    const SizedBox(height: 4),
                    Text(contact.phoneNumber, style: AppTextStyles.bodyRegular),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return CachedNetworkImageProvider(path);
    } else if (!path.startsWith('/')) {
      return CachedNetworkImageProvider('${ApiConstants.baseUrl}$path');
    } else {
      return FileImage(File(path));
    }
  }
}
