import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as flutter_contacts;
import 'package:shared_preferences/shared_preferences.dart';
import '../contacts_repository.dart';
import '../model/contact.dart';

class ContactsViewModel extends ChangeNotifier {
  final ContactsRepository _repository = ContactsRepository();
  List<Contact> _contacts = [];
  final Set<String> _devicePhoneNumbers = {};
  bool _isLoading = false;
  String? _error;
  bool _showUpdateSuccess = false;

  List<Contact> get contacts => _contacts;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get showUpdateSuccess => _showUpdateSuccess;

  bool _showDeleteSuccess = false;
  bool get showDeleteSuccess => _showDeleteSuccess;

  void showUpdateSuccessMessage() {
    _showUpdateSuccess = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      _showUpdateSuccess = false;
      notifyListeners();
    });
  }

  void showDeleteSuccessMessage() {
    _showDeleteSuccess = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      _showDeleteSuccess = false;
      notifyListeners();
    });
  }

  ContactsViewModel() {
    _init();
  }

  Future<void> _init() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.wait([
        _fetchContacts(),
        refreshDeviceContacts(),
        _loadSearchHistory(),
      ]);
    } catch (e) {
      debugPrint('Error initializing contacts view model: $e');
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

  Future<void> refreshDeviceContacts() async {
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
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error fetching device contacts: $e');
    }
  }

  String _normalizePhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[^\d+]'), '');
  }

  final List<String> _searchHistory = [];
  List<String> get searchHistory => _searchHistory;

  void addToHistory(String query) {
    if (query.isNotEmpty && !_searchHistory.contains(query)) {
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 5) _searchHistory.removeLast();
      _saveSearchHistory();
      notifyListeners();
    }
  }

  void removeFromHistory(String query) {
    _searchHistory.remove(query);
    _saveSearchHistory();
    notifyListeners();
  }

  void clearHistory() {
    _searchHistory.clear();
    _saveSearchHistory();
    notifyListeners();
  }

  List<Contact> get filteredContacts {
    if (_searchQuery.isEmpty) return _contacts;
    final query = _searchQuery.toLowerCase();
    return _contacts.where((c) {
      final first = c.firstName.toLowerCase();
      final last = c.lastName.toLowerCase();
      return first.startsWith(query) || last.startsWith(query);
    }).toList();
  }

  bool isContactInDevice(String phoneNumber) {
    return _devicePhoneNumbers.contains(_normalizePhoneNumber(phoneNumber));
  }

  String _searchQuery = '';

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Map<String, List<Contact>> get groupedContacts {
    var filteredContacts = _contacts;
    if (_searchQuery.isNotEmpty) {
      filteredContacts = _contacts
          .where(
            (c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    final sortedContacts = List<Contact>.from(filteredContacts)
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

  Future<String> uploadImage(String filePath) async {
    try {
      return await _repository.uploadImage(filePath);
    } catch (e) {
      debugPrint('Error uploading image: $e');
      rethrow;
    }
  }

  Future<void> updateContact(Contact contact) async {
    try {
      await _repository.updateContact(contact);
      await _fetchContacts();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error updating contact: $e');
      rethrow;
    }
  }

  Future<void> saveContactToDevice(Contact contact) async {
    try {
      if (await flutter_contacts.FlutterContacts.requestPermission()) {
        final newContact = flutter_contacts.Contact()
          ..name.first = contact.firstName
          ..name.last = contact.lastName
          ..phones = [flutter_contacts.Phone(contact.phoneNumber)];

        await newContact.insert();
        await refreshDeviceContacts();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error saving to device: $e');
      rethrow;
    }
  }

  Future<void> deleteContact(Contact contact) async {
    try {
      await _repository.deleteContact(contact.id);
      await _fetchContacts();
      showDeleteSuccessMessage();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      debugPrint('Error deleting contact: $e');
    }
  }

  Future<void> _loadSearchHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final history = prefs.getStringList('search_history');
      debugPrint('Loaded history: $history');
      if (history != null) {
        _searchHistory.clear();
        _searchHistory.addAll(history);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading search history: $e');
    }
  }

  Future<void> _saveSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint('Saving history: $_searchHistory');
    await prefs.setStringList('search_history', _searchHistory);
  }
}
