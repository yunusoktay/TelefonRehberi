import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/contact.dart';
import '../contacts/contacts_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final Contact contact;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;

  String? _newImagePath;
  String? get imagePath => _newImagePath ?? contact.imagePath;

  bool _isSavingToDevice = false;
  bool get isSavingToDevice => _isSavingToDevice;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _showSuccess = false;
  bool get showSuccess => _showSuccess;

  void toggleEditing() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void showSuccessMessage() {
    _showSuccess = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      _showSuccess = false;
      notifyListeners();
    });
  }

  ProfileViewModel(this.contact) {
    firstNameController = TextEditingController(text: contact.firstName);
    lastNameController = TextEditingController(text: contact.lastName);
    phoneNumberController = TextEditingController(text: contact.phoneNumber);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      _newImagePath = image.path;
      notifyListeners();
    }
  }

  Future<void> updateProfile(ContactsViewModel viewModel) async {
    String? finalImageUrl = contact.imagePath;
    if (_newImagePath != null) {
      finalImageUrl = await viewModel.uploadImage(_newImagePath!);
    }

    final updatedContact = Contact(
      id: contact.id,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneNumberController.text,
      imagePath: finalImageUrl,
    );

    await viewModel.updateContact(updatedContact);
  }

  Future<void> saveToDevice(ContactsViewModel viewModel) async {
    _isSavingToDevice = true;
    notifyListeners();
    try {
      await viewModel.saveContactToDevice(contact);
    } finally {
      _isSavingToDevice = false;
      notifyListeners();
    }
  }
}
