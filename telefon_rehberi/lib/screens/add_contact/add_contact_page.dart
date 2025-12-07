import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telefon_rehberi/core/theme/app_colors.dart';
import 'add_contact_view_model.dart';
import '../contacts/contacts_view_model.dart';
import 'widgets/photo_selector.dart';
import 'widgets/add_contact_header.dart';
import 'widgets/add_contact_form.dart';
import 'widgets/success_animation_screen.dart';
import 'widgets/photo_selection_sheet.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleSave(
      BuildContext context,
      AddContactViewModel viewModel,
    ) async {
      final navigator = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);

      final contactsViewModel = Provider.of<ContactsViewModel>(
        context,
        listen: false,
      );

      final success = await viewModel.saveContact(contactsViewModel);

      if (success) {
        navigator.pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const SuccessAnimationScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          navigator.pop();
        });
      } else {
        if (context.mounted && viewModel.error != null) {
          messenger.showSnackBar(
            SnackBar(
              content: Text('Failed to save contact: ${viewModel.error}'),
            ),
          );
        }
      }
    }

    return ChangeNotifierProvider(
      create: (_) => AddContactViewModel(),
      child: Consumer<AddContactViewModel>(
        builder: (context, viewModel, child) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                backgroundColor: AppColors.cardBackground,
                body: SafeArea(
                  child: Column(
                    children: [
                      AddContactHeader(
                        onCancel: () => Navigator.pop(context),
                        canSave: viewModel.canSave,
                        onSave: () => handleSave(context, viewModel),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 36),
                              PhotoSelector(
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
                              AddContactForm(
                                onFirstNameChanged: viewModel.setFirstName,
                                onLastNameChanged: viewModel.setLastName,
                                onPhoneNumberChanged: viewModel.setPhoneNumber,
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
            ),
          );
        },
      ),
    );
  }
}
