import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
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
