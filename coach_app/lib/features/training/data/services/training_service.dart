import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/training.dart';

class TrainingService {
  TrainingService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('trainings');

  Future<void> createTraining(Training training) async {
    await _collection.doc(training.id).set(training.toMap());
  }

  Future<Training?> getTraining(String trainingId) async {
    final document = await _collection.doc(trainingId).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return Training.fromMap(
      document.id,
      document.data()!,
    );
  }

  Future<List<Training>> getUserTrainings(String userId) async {
    final snapshot = await _collection
        .where('userId', isEqualTo: userId)
        .orderBy('startDate')
        .get();

    return snapshot.docs
        .map(
          (document) => Training.fromMap(
        document.id,
        document.data(),
      ),
    )
        .toList();
  }

  Future<void> updateTraining(Training training) async {
    await _collection.doc(training.id).update(training.toMap());
  }

  Future<void> deleteTraining(String trainingId) async {
    await _collection.doc(trainingId).delete();
  }
}
