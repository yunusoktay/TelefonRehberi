import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'contacts_view_model.dart';
import 'widgets/contacts_header.dart';
import 'widgets/contact_search_bar.dart';
import 'widgets/contacts_empty_state.dart';
import 'widgets/search_history_view.dart';
import 'widgets/search_results_view.dart';
import 'widgets/contact_list_view.dart';
import '../profile/profile_page.dart';
import '../../core/widgets/success_toast.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final FocusNode _dummyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _searchFocusNode.removeListener(_onFocusChange);
    _searchFocusNode.dispose();
    _dummyFocusNode.dispose();
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

  void _onBeforeModalOpen() {
    _searchController.clear();

    FocusScope.of(context).requestFocus(_dummyFocusNode);
    setState(() {});
  }

  void _onAfterModalClose() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<ContactsViewModel>(
        builder: (context, contactsViewModel, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFF9F9F9),
            body: Stack(
              children: [
                SizedBox.shrink(
                  child: Focus(
                    focusNode: _dummyFocusNode,
                    child: const SizedBox.shrink(),
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ContactsHeader(
                          onBeforeModalOpen: _onBeforeModalOpen,
                          onAfterModalClose: _onAfterModalClose,
                        ),
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

                                final filteredContacts =
                                    viewModel.filteredContacts;
                                if (filteredContacts.isEmpty) {
                                  return const SearchEmptyState();
                                } else {
                                  return SearchResultsView(
                                    contacts: filteredContacts,
                                    isDeviceContact:
                                        viewModel.isContactInDevice,
                                    onDelete: (contact) {
                                      viewModel.deleteContact(contact);
                                      _searchController.clear();
                                      _onSearchQueryChanged('');
                                    },
                                  );
                                }
                              }

                              if (viewModel.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (viewModel.error != null) {
                                return Center(
                                  child: Text('Error: ${viewModel.error}'),
                                );
                              }
                              final groupedContacts = viewModel.groupedContacts;
                              if (groupedContacts.isNotEmpty) {
                                return ContactListView(
                                  groupedContacts: groupedContacts,
                                  isContactInDevice:
                                      viewModel.isContactInDevice,
                                  onDelete: (contact) =>
                                      viewModel.deleteContact(contact),
                                  onTap: (contact) async {
                                    _onBeforeModalOpen();
                                    FocusScope.of(context).unfocus();
                                    await showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      barrierColor: const Color(0xFF616161),
                                      enableDrag: true,
                                      isDismissible: true,
                                      builder: (context) =>
                                          ProfilePage(contact: contact),
                                    );
                                    if (context.mounted) {
                                      await Future.delayed(
                                        const Duration(milliseconds: 100),
                                      );
                                      if (context.mounted) {
                                        FocusScope.of(context).unfocus();
                                        _onAfterModalClose();
                                      }
                                    }
                                  },
                                );
                              } else {
                                return ContactsEmptyState(
                                  onBeforeModalOpen: _onBeforeModalOpen,
                                  onAfterModalClose: _onAfterModalClose,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (contactsViewModel.showUpdateSuccess)
                  const Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: SuccessToast(message: 'User is updated!'),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
