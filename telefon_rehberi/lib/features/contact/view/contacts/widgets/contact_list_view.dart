import 'package:flutter/material.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'package:telefon_rehberi/features/contact/model/contact.dart';
import 'contact_card.dart';

class ContactListView extends StatelessWidget {
  final Map<String, List<Contact>> groupedContacts;
  final bool Function(String) isContactInDevice;
  final Function(Contact) onTap;
  final Function(Contact) onEdit;
  final Function(Contact) onDelete;

  const ContactListView({
    super.key,
    required this.groupedContacts,
    required this.isContactInDevice,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final sortedKeys = groupedContacts.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 40),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final letter = sortedKeys[index];
        final contacts = groupedContacts[letter]!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
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
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Text(letter, style: AppTextStyles.titleLarge),
                ),
                const Divider(
                  height: 1,
                  color: AppColors.divider,
                  indent: 16,
                  endIndent: 16,
                ),
                Column(
                  children: [
                    for (int i = 0; i < contacts.length; i++) ...[
                      ContactCard(
                        contact: contacts[i],
                        isDeviceContact: isContactInDevice(
                          contacts[i].phoneNumber,
                        ),
                        onTap: () => onTap(contacts[i]),
                        onEdit: () => onEdit(contacts[i]),
                        onDelete: () => onDelete(contacts[i]),
                      ),
                      if (i != contacts.length - 1)
                        const Divider(
                          height: 1,
                          color: AppColors.divider,
                          indent: 16,
                          endIndent: 16,
                        ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
