import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telefon_rehberi/model/contact.dart';
import '../contacts/contacts_view_model.dart';
import '../add_contact/widgets/photo_selection_sheet.dart';
import 'profile_view_model.dart';
import '../../core/widgets/success_toast.dart';
import 'widgets/profile_edit_header.dart';
import 'widgets/profile_view_header.dart';
import 'widgets/profile_photo_selector.dart';
import 'widgets/profile_form.dart';
import 'widgets/save_to_device_button.dart';

class ProfilePage extends StatelessWidget {
  final Contact contact;

  const ProfilePage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(contact),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          final contactsViewModel = Provider.of<ContactsViewModel>(context);

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Header
                      if (viewModel.isEditing)
                        ProfileEditHeader(
                          onCancel: () {
                            viewModel.toggleEditing();
                          },
                          onDone: () async {
                            final success = await viewModel.updateProfile(
                              contactsViewModel,
                            );
                            if (success && context.mounted) {
                              contactsViewModel.showUpdateSuccessMessage();
                              Navigator.pop(context);
                            }
                          },
                        )
                      else
                        ProfileViewHeader(
                          onEdit: () => viewModel.toggleEditing(),
                          onDelete: () {
                            contactsViewModel.deleteContact(contact);
                            Navigator.pop(context);
                          },
                        ),

                      const SizedBox(height: 32),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfilePhotoSelector(
                                imagePath: viewModel.imagePath,
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => PhotoSelectionSheet(
                                      onImageSourceSelected: (source) {
                                        viewModel.pickImage(source);
                                      },
                                    ),
                                  );
                                },
                              ),

                              const SizedBox(height: 32),

                              const ProfileForm(),

                              const SizedBox(height: 40),

                              if (!viewModel.isEditing)
                                SaveToDeviceButton(
                                  isSaved: contactsViewModel.isContactInDevice(
                                    contact.phoneNumber,
                                  ),
                                  onPressed: () async {
                                    final success = await viewModel
                                        .saveToDevice(contactsViewModel);
                                    if (success) {
                                      viewModel.showSuccessMessage();
                                    }
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (viewModel.showSuccess)
                  const Positioned(
                    bottom: 40,
                    left: 16,
                    right: 16,
                    child: SuccessToast(
                      message: 'User is added to your phone!',
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
