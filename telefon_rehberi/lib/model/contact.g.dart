// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
  id: json['id'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  imagePath: json['profileImageUrl'] as String?,
);

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
  'id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'profileImageUrl': instance.imagePath,
};
