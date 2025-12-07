import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/api_client.dart';
import '../../model/contact.dart';

class ContactsService {
  final ApiClient _apiClient;

  ContactsService() : _apiClient = ApiClient();

  Future<List<Contact>> getContacts() async {
    try {
      final response = await _apiClient.dio.get(
        ApiConstants.getAllUsersEndpoint,
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data']['users'];
        return data.map((json) => Contact.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to load contacts: $e');
    }
  }

  Future<void> addContact(Contact contact) async {
    try {
      await _apiClient.dio.post(
        ApiConstants.userEndpoint,
        data: contact.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to add contact: $e');
    }
  }

  Future<void> updateContact(Contact contact) async {
    try {
      await _apiClient.dio.put(
        '${ApiConstants.userEndpoint}/${contact.id}',
        data: contact.toJson(),
      );
    } catch (e) {
      throw Exception('Failed to update contact: $e');
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _apiClient.dio.delete('${ApiConstants.userEndpoint}/$id');
    } catch (e) {
      throw Exception('Failed to delete contact: $e');
    }
  }

  Future<String> uploadImage(String filePath) async {
    try {
      String fileName = filePath.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await _apiClient.dio.post(
        ApiConstants.uploadImageEndpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['data']['imageUrl'];
      }
      throw Exception('Failed to upload image');
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
