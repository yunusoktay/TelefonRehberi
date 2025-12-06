import 'package:flutter/material.dart';
import '../../model/contact.dart';

class ContactsViewModel extends ChangeNotifier {
  final List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  List<Contact> searchContacts(String query) {
    if (query.isEmpty) {
      return _contacts;
    }
    return _contacts
        .where(
          (contact) => contact.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
