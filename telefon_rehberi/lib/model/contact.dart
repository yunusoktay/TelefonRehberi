import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  @JsonKey(name: 'profileImageUrl')
  final String? imagePath;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.imagePath,
  });

  String get name => '$firstName $lastName';

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}
