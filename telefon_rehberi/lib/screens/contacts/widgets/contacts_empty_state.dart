import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import '../../add_contact/add_contact_page.dart';

class ContactsEmptyState extends StatelessWidget {
  const ContactsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Spacer(flex: 2),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.avatarPlaceholder,
          ),
          child: Center(
            child: Icon(Icons.person, size: 60, color: AppColors.iconColor),
          ),
        ),
        const SizedBox(height: 20),
        Text('No Contacts', style: AppTextStyles.headline),
        const SizedBox(height: 10),
        Text(
          'Contacts you’ve added will appear here.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyRegular.copyWith(fontSize: 16),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: const AddContactPage(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text(
            'Create New Contact',
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 17,
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
