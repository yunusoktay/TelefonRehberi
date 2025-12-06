class Contact {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? imagePath;

  Contact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.imagePath,
  });

  String get name => '$firstName $lastName';
}
