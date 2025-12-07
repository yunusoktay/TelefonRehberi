import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contacts_view_model.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'widgets/contacts_header.dart';
import 'widgets/contact_search_bar.dart';
import 'widgets/contacts_empty_state.dart';
import 'widgets/contact_card.dart';

@RoutePage()
class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const ContactsHeader(),
              const SizedBox(height: 20),
              ContactSearchBar(
                onChanged: (value) {
                  // TODO: Connect to ViewModel search
                },
              ),
              Expanded(
                child: Consumer<ContactsViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (viewModel.error != null) {
                      return Center(child: Text('Error: ${viewModel.error}'));
                    }
                    final groupedContacts = viewModel.groupedContacts;
                    if (groupedContacts.isNotEmpty) {
                      final sortedKeys = groupedContacts.keys.toList()..sort();
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      12,
                                      16,
                                      8,
                                    ),
                                    child: Text(
                                      letter,
                                      style: AppTextStyles.titleLarge,
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: AppColors.divider,
                                    indent: 16,
                                    endIndent: 16,
                                  ),

                                  Column(
                                    children: [
                                      for (
                                        int i = 0;
                                        i < contacts.length;
                                        i++
                                      ) ...[
                                        ContactCard(
                                          contact: contacts[i],
                                          isDeviceContact: viewModel
                                              .isContactInDevice(
                                                contacts[i].phoneNumber,
                                              ),
                                          onTap: () {
                                            // TODO: Navigate to details
                                          },
                                          onEdit: () {
                                            // TODO: Implement Edit
                                          },
                                          onDelete: () {
                                            viewModel.deleteContact(
                                              contacts[i],
                                            );
                                          },
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
                    } else {
                      return const ContactsEmptyState();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
