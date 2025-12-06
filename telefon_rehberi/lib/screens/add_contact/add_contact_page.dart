import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_contact_view_model.dart';
import '../contacts/contacts_view_model.dart';
import '../../model/contact.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddContactViewModel(),
      child: Consumer<AddContactViewModel>(
        builder: (context, viewModel, child) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Scaffold(
              backgroundColor: const Color(0xFFFFFFFF),
              body: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 36, 16, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Color(0xFF007AFF),
                                fontSize: 17,
                              ),
                            ),
                          ),
                          const Text(
                            'New Contact',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          GestureDetector(
                            onTap: viewModel.canSave
                                ? () {
                                    final contactsViewModel =
                                        Provider.of<ContactsViewModel>(
                                          context,
                                          listen: false,
                                        );

                                    final newContact = Contact(
                                      id: DateTime.now().toString(),
                                      firstName: viewModel.firstName,
                                      lastName: viewModel.lastName,
                                      phoneNumber: viewModel.phoneNumber,
                                      imagePath: viewModel.imagePath,
                                    );

                                    contactsViewModel.addContact(newContact);
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: Text(
                              'Done',
                              style: TextStyle(
                                color: viewModel.canSave
                                    ? const Color(0xFF007AFF)
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 36),

                            GestureDetector(
                              onTap: viewModel.pickImage,
                              child: Column(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      shape: BoxShape.circle,
                                      image: viewModel.imagePath != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                File(viewModel.imagePath!),
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                    ),
                                    child: viewModel.imagePath == null
                                        ? const Icon(
                                            Icons.person,
                                            size: 100,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Add Photo',
                                    style: TextStyle(
                                      color: Color(0xFF007AFF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                children: [
                                  _buildModernTextField(
                                    placeholder: 'First Name',
                                    onChanged: viewModel.setFirstName,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildModernTextField(
                                    placeholder: 'Last Name',
                                    onChanged: viewModel.setLastName,
                                  ),
                                  const SizedBox(height: 10),
                                  _buildModernTextField(
                                    placeholder: 'Phone Number',
                                    onChanged: viewModel.setPhoneNumber,
                                    keyboardType: TextInputType.phone,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernTextField({
    required String placeholder,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 17),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          isDense: true,
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        cursorColor: const Color(0xFF007AFF),
      ),
    );
  }
}
