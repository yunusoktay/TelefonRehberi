import 'package:flutter/material.dart';
import 'custom_text_field.dart';

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
          CustomTextField(
            placeholder: 'First Name',
            onChanged: onFirstNameChanged,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            placeholder: 'Last Name',
            onChanged: onLastNameChanged,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            placeholder: 'Phone Number',
            onChanged: onPhoneNumberChanged,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
