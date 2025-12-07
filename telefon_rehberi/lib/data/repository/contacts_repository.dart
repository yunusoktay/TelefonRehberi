import '../../model/contact.dart';
import '../service/contacts_service.dart';

class ContactsRepository {
  final ContactsService _service;

  ContactsRepository() : _service = ContactsService();

  Future<List<Contact>> getContacts() => _service.getContacts();

  Future<void> addContact(Contact contact) => _service.addContact(contact);

  Future<void> updateContact(Contact contact) =>
      _service.updateContact(contact);

  Future<void> deleteContact(String id) => _service.deleteContact(id);

  Future<String> uploadImage(String filePath) => _service.uploadImage(filePath);
}
