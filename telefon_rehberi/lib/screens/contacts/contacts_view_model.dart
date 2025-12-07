import 'package:flutter/material.dart';
import '../../model/contact.dart';

class ContactsViewModel extends ChangeNotifier {
  final List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  Map<String, List<Contact>> get groupedContacts {
    final sortedContacts = List<Contact>.from(_contacts)
      ..sort(
        (a, b) =>
            a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()),
      );

    final Map<String, List<Contact>> groups = {};
    for (var contact in sortedContacts) {
      if (contact.firstName.isEmpty) continue;
      final letter = contact.firstName[0].toUpperCase();
      if (groups[letter] == null) {
        groups[letter] = [];
      }
      groups[letter]!.add(contact);
    }
    return groups;
  }

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

  void deleteContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }
}
