import 'package:hive/hive.dart';
import 'model/contact.dart';
import 'service/contacts_service.dart';

class ContactsRepository {
  final ContactsService _service;
  final Box<Contact> _contactsBox = Hive.box<Contact>('contacts');

  ContactsRepository() : _service = ContactsService();

  Future<List<Contact>> getContacts() => _service.getContacts();

  List<Contact> getLocalContacts() => _contactsBox.values.toList();

  Future<void> saveLocalContacts(List<Contact> contacts) async {
    await _contactsBox.clear();
    await _contactsBox.addAll(contacts);
  }

  Future<void> addContact(Contact contact) => _service.addContact(contact);

  Future<void> updateContact(Contact contact) =>
      _service.updateContact(contact);

  Future<void> deleteContact(String id) => _service.deleteContact(id);

  Future<String> uploadImage(String filePath) => _service.uploadImage(filePath);
}
