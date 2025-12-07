import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/contact.dart';
import '../contacts/contacts_view_model.dart';

class AddContactViewModel extends ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String? _imagePath;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String? get imagePath => _imagePath;

  bool get canSave => _firstName.isNotEmpty && _phoneNumber.isNotEmpty;

  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      _imagePath = image.path;
      notifyListeners();
    }
  }

  Future<void> saveContact(ContactsViewModel contactsViewModel) async {
    if (!canSave) return;

    String? imageUrl;
    if (_imagePath != null) {
      try {
        imageUrl = await contactsViewModel.uploadImage(_imagePath!);
      } catch (e) {
        rethrow;
      }
    }

    final newContact = Contact(
      id: DateTime.now().toString(),
      firstName: _firstName,
      lastName: _lastName,
      phoneNumber: _phoneNumber,
      imagePath: imageUrl,
    );

    await contactsViewModel.addContact(newContact);
  }
}
