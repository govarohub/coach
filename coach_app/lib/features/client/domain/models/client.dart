import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  const Client({
    required this.id,
    required this.coachId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;

  final String coachId;

  final String firstName;

  final String lastName;

  final String email;

  final String phone;

  final DateTime birthDate;

  final String gender;

  final String status;

  final DateTime createdAt;

  final DateTime updatedAt;

  factory Client.fromMap(
      String id,
      Map<String, dynamic> data,
      ) {
    return Client(
      id: id,
      coachId: data['coachId'] as String? ?? '',
      firstName: data['firstName'] as String? ?? '',
      lastName: data['lastName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      birthDate: _toDateTime(data['birthDate']),
      gender: data['gender'] as String? ?? '',
      status: data['status'] as String? ?? 'active',
      createdAt: _toDateTime(data['createdAt']),
      updatedAt: _toDateTime(data['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coachId': coachId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'birthDate': Timestamp.fromDate(birthDate),
      'gender': gender,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  static DateTime _toDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.now();
  }
}
