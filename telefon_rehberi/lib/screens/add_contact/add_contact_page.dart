import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_contact_view_model.dart';
import '../contacts/contacts_view_model.dart';
import 'widgets/photo_selector.dart';
import 'widgets/add_contact_header.dart';
import 'widgets/add_contact_form.dart';
import 'widgets/success_animation_screen.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    void _handleSave(BuildContext context, AddContactViewModel viewModel) {
      final navigator = Navigator.of(context);

      final contactsViewModel = Provider.of<ContactsViewModel>(
        context,
        listen: false,
      );

      viewModel.saveContact(contactsViewModel);

      navigator.pushReplacement(
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) =>
                  const SuccessAnimationScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );

      Future.delayed(const Duration(seconds: 3), () {
        navigator.pop();
      });
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
            child: Scaffold(
              backgroundColor: const Color(0xFFFFFFFF),
              body: SafeArea(
                child: Column(
                  children: [
                    AddContactHeader(
                      onCancel: () => Navigator.pop(context),
                      canSave: viewModel.canSave,
                      onSave: () => _handleSave(context, viewModel),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 36),
                            PhotoSelector(
                              imagePath: viewModel.imagePath,
                              onTap: viewModel.pickImage,
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
          );
        },
      ),
    );
  }
}
