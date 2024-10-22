import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum Gender {
  male,
  female,
  other,
}

class Users {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime birthday;
  final String phoneNumber;
  final Gender gender;
  final String city;
  final int postalCode;

  Users({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthday,
    required this.phoneNumber,
    required this.gender,
    required this.city,
    required this.postalCode,
    String? id,
  }) : id = id ?? uuid.v4();
}
