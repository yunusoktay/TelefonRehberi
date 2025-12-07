import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contacts_view_model.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'package:telefon_rehberi/core/theme/app_text_styles.dart';
import 'widgets/contacts_header.dart';
import 'widgets/contact_search_bar.dart';
import 'widgets/contacts_empty_state.dart';
import 'widgets/contact_card.dart';
import 'widgets/search_history_view.dart';
import 'widgets/search_results_view.dart';
import '../profile/profile_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _onSearchQueryChanged(String query) {
    setState(() {});
    Provider.of<ContactsViewModel>(
      context,
      listen: false,
    ).updateSearchQuery(query);
  }

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      Provider.of<ContactsViewModel>(
        context,
        listen: false,
      ).addToHistory(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onChanged: _onSearchQueryChanged,
                  onSubmitted: _onSearchSubmitted,
                ),
                Expanded(
                  child: Consumer<ContactsViewModel>(
                    builder: (context, viewModel, child) {
                      final bool isSearching =
                          _searchFocusNode.hasFocus ||
                          _searchController.text.isNotEmpty;

                      if (isSearching) {
                        if (_searchController.text.isEmpty) {
                          return SearchHistoryView(
                            history: viewModel.searchHistory,
                            onClearAll: viewModel.clearHistory,
                            onDelete: viewModel.removeFromHistory,
                            onSelect: (value) {
                              _searchController.text = value;
                              _onSearchQueryChanged(value);
                              _searchFocusNode.unfocus();
                              _onSearchSubmitted(value);
                            },
                          );
                        }

                        final filteredContacts = viewModel.filteredContacts;
                        if (filteredContacts.isEmpty) {
                          return const SearchEmptyState();
                        } else {
                          return SearchResultsView(
                            contacts: filteredContacts,
                            isDeviceContact: viewModel.isContactInDevice,
                            onDelete: (contact) {
                              viewModel.deleteContact(contact);
                              _searchController.clear();
                              _onSearchQueryChanged('');
                            },
                          );
                        }
                      }

                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (viewModel.error != null) {
                        return Center(child: Text('Error: ${viewModel.error}'));
                      }
                      final groupedContacts = viewModel.groupedContacts;
                      if (groupedContacts.isNotEmpty) {
                        final sortedKeys = groupedContacts.keys.toList()
                          ..sort();
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
                                              showModalBottomSheet(
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                isScrollControlled: true,
                                                barrierColor: const Color(
                                                  0xFF616161,
                                                ),
                                                builder: (context) =>
                                                    ProfilePage(
                                                      contact: contacts[i],
                                                    ),
                                              );
                                            },
                                            onEdit: () {},
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
      ),
    );
  }
}
