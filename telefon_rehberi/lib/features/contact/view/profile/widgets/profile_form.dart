import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/contacts_view_model.dart';
import '../../../viewmodel/profile_view_model.dart';
import '../../../../../core/widgets/app_text_field.dart';

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
            AppTextField(
              controller: viewModel.firstNameController,
              hintText: 'First Name',
              enabled: viewModel.isEditing,
              onSubmitted: (_) => viewModel.updateProfile(contactsViewModel),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: viewModel.lastNameController,
              hintText: 'Last Name',
              enabled: viewModel.isEditing,
              onSubmitted: (_) => viewModel.updateProfile(contactsViewModel),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: viewModel.phoneNumberController,
              hintText: 'Phone Number',
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
