import 'package:flutter/material.dart';
import '../../../core/widgets/app_text_field.dart';

class AddContactForm extends StatelessWidget {
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final ValueChanged<String> onPhoneNumberChanged;

  const AddContactForm({
    super.key,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onPhoneNumberChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          AppTextField(hintText: 'First Name', onChanged: onFirstNameChanged),
          const SizedBox(height: 10),
          AppTextField(hintText: 'Last Name', onChanged: onLastNameChanged),
          const SizedBox(height: 10),
          AppTextField(
            hintText: 'Phone Number',
            onChanged: onPhoneNumberChanged,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
