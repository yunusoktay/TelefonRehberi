import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:telefon_rehberi/model/contact.dart';
import '../contacts/contacts_view_model.dart';
import 'profile_view_model.dart';
import '../add_contact/widgets/photo_selection_sheet.dart';
import 'widgets/profile_edit_header.dart';
import 'widgets/profile_view_header.dart';
import 'widgets/profile_photo_selector.dart';
import 'widgets/profile_text_field.dart';
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

          return Stack(
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
                          await viewModel.updateProfile(contactsViewModel);
                          if (context.mounted) {
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

                            ProfileTextField(
                              controller: viewModel.firstNameController,
                              hint: 'First Name',
                              enabled: viewModel.isEditing,
                              onSubmitted: (_) =>
                                  viewModel.updateProfile(contactsViewModel),
                            ),
                            const SizedBox(height: 16),
                            ProfileTextField(
                              controller: viewModel.lastNameController,
                              hint: 'Last Name',
                              enabled: viewModel.isEditing,
                              onSubmitted: (_) =>
                                  viewModel.updateProfile(contactsViewModel),
                            ),
                            const SizedBox(height: 16),
                            ProfileTextField(
                              controller: viewModel.phoneNumberController,
                              hint: 'Phone Number',
                              keyboardType: TextInputType.phone,
                              enabled: viewModel.isEditing,
                              onSubmitted: (_) =>
                                  viewModel.updateProfile(contactsViewModel),
                            ),

                            const SizedBox(height: 40),

                            SaveToDeviceButton(
                              isSaved: contactsViewModel.isContactInDevice(
                                contact.phoneNumber,
                              ),
                              onPressed: () async {
                                await viewModel.saveToDevice(contactsViewModel);
                                viewModel.showSuccessMessage();
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
                Positioned(
                  bottom: 40,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/done.svg',
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'User is added to your phone!',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
