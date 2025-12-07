import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import '../../../model/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactCard({
    super.key,
    required this.contact,
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
        children: [
          SlidableAction(
            onPressed: (context) => onEdit?.call(),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) => onDelete?.call(),
            backgroundColor: AppColors.redDelete,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
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
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.avatarPlaceholder,
                  image: contact.imagePath != null
                      ? DecorationImage(
                          image: FileImage(File(contact.imagePath!)),
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
                            color: AppColors.sectionHeader,
                          ),
                        ),
                      )
                    : null,
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
}
