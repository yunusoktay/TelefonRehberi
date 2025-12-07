import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as flutter_contacts;
import '../../data/repository/contacts_repository.dart';
import '../../model/contact.dart';

class ContactsViewModel extends ChangeNotifier {
  final ContactsRepository _repository = ContactsRepository();
  List<Contact> _contacts = [];
  final Set<String> _devicePhoneNumbers = {};
  bool _isLoading = false;
  String? _error;

  List<Contact> get contacts => _contacts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  ContactsViewModel() {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([_fetchContacts(), _fetchDeviceContacts()]);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _fetchContacts() async {
    try {
      _contacts = await _repository.getContacts();
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading API contacts: $e');
    }
  }

  Future<void> _fetchDeviceContacts() async {
    try {
      if (await flutter_contacts.FlutterContacts.requestPermission(
        readonly: true,
      )) {
        final deviceContacts = await flutter_contacts
            .FlutterContacts.getContacts(withProperties: true);

        _devicePhoneNumbers.clear();
        for (var c in deviceContacts) {
          for (var phone in c.phones) {
            _devicePhoneNumbers.add(_normalizePhoneNumber(phone.number));
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching device contacts: $e');
    }
  }

  String _normalizePhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }

  bool isContactInDevice(String phoneNumber) {
    return _devicePhoneNumbers.contains(_normalizePhoneNumber(phoneNumber));
  }

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

  Future<void> addContact(Contact contact) async {
    try {
      await _repository.addContact(contact);
      await _fetchContacts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error adding contact: $e');
      rethrow;
    }
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

  Future<String> uploadImage(String filePath) async {
    try {
      return await _repository.uploadImage(filePath);
    } catch (e) {
      debugPrint('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> deleteContact(Contact contact) async {
    try {
      await _repository.deleteContact(contact.id);
      await _fetchContacts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error deleting contact: $e');
    }
  }
}
