import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'package:telefon_rehberi/model/contact.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'contact_card.dart';

class SearchResultsView extends StatelessWidget {
  final List<Contact> contacts;
  final Function(Contact) onDelete;
  final bool Function(String) isDeviceContact;

  const SearchResultsView({
    super.key,
    required this.contacts,
    required this.onDelete,
    required this.isDeviceContact,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Text(
                  'TOP NAME MATCHES',
                  style: AppTextStyles.bodyRegular.copyWith(
                    color: AppColors.gray300,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: AppColors.divider,
              ),
              Column(
                children: [
                  for (int i = 0; i < contacts.length; i++) ...[
                    ContactCard(
                      contact: contacts[i],
                      isDeviceContact: isDeviceContact(contacts[i].phoneNumber),
                      onTap: () {},
                      onDelete: () => onDelete(contacts[i]),
                    ),
                    if (i != contacts.length - 1)
                      const Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: AppColors.divider,
                      ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: const BoxDecoration(
              color: Color(0xFFE0E0E0),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/noResult.svg',
              width: 56,
              height: 56,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Results',
            style: AppTextStyles.headline.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.normal,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'The user you are looking for could not be found.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
