import 'package:cloud_firestore/cloud_firestore.dart';

class Training {
  const Training({
    required this.id,
    required this.coachId,
    required this.userId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;

  final String coachId;

  final String userId;

  final String title;

  final String description;

  final DateTime startDate;

  final DateTime endDate;

  final String status;

  final DateTime createdAt;

  final DateTime updatedAt;

  factory Training.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return Training(
      id: id,
      coachId: data['coachId'] as String? ?? '',
      userId: data['userId'] as String? ?? '',
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      startDate: _toDateTime(data['startDate']),
      endDate: _toDateTime(data['endDate']),
      status: data['status'] as String? ?? 'scheduled',
      createdAt: _toDateTime(data['createdAt']),
      updatedAt: _toDateTime(data['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coachId': coachId,
      'userId': userId,
      'title': title,
      'description': description,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
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
