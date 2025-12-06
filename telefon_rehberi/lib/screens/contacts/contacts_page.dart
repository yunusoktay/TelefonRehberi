import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contacts_view_model.dart';
import 'widgets/contacts_header.dart';
import 'widgets/contact_search_bar.dart';
import 'widgets/contacts_empty_state.dart';
import 'widgets/contact_card.dart';

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
                    if (viewModel.contacts.isNotEmpty) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: viewModel.contacts.length,
                        itemBuilder: (context, index) {
                          final contact = viewModel.contacts[index];
                          return ContactCard(
                            contact: contact,
                            onTap: () {
                              // TODO: Navigate to details
                            },
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
