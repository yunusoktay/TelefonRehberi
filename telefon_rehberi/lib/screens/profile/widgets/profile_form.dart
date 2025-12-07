import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../contacts/contacts_view_model.dart';
import '../profile_view_model.dart';
import 'profile_text_field.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, viewModel, child) {
        final contactsViewModel = Provider.of<ContactsViewModel>(
          context,
          listen: false,
        );

        return Column(
          children: [
            ProfileTextField(
              controller: viewModel.firstNameController,
              hint: 'First Name',
              enabled: viewModel.isEditing,
              onSubmitted: (_) => viewModel.updateProfile(contactsViewModel),
            ),
            const SizedBox(height: 16),
            ProfileTextField(
              controller: viewModel.lastNameController,
              hint: 'Last Name',
              enabled: viewModel.isEditing,
              onSubmitted: (_) => viewModel.updateProfile(contactsViewModel),
            ),
            const SizedBox(height: 16),
            ProfileTextField(
              controller: viewModel.phoneNumberController,
              hint: 'Phone Number',
              keyboardType: TextInputType.phone,
              enabled: viewModel.isEditing,
              onSubmitted: (_) => viewModel.updateProfile(contactsViewModel),
            ),
          ],
        );
      },
    );
  }
}
