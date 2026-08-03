import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/client.dart';

class ClientService {
  ClientService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('clients');

  Future<void> createClient(Client client) async {
    await _collection.doc(client.id).set(client.toMap());
  }

  Future<Client?> getClient(String clientId) async {
    final document = await _collection.doc(clientId).get();

    if (!document.exists || document.data() == null) {
      return null;
    }

    return Client.fromMap(
      document.id,
      document.data()!,
    );
  }

  Future<List<Client>> getCoachClients(String coachId) async {
    final snapshot = await _collection
        .where('coachId', isEqualTo: coachId)
        .orderBy('lastName')
        .get();

    return snapshot.docs
        .map(
          (document) => Client.fromMap(
        document.id,
        document.data(),
      ),
    )
        .toList();
  }

  Future<void> updateClient(Client client) async {
    await _collection.doc(client.id).update(client.toMap());
  }

  Future<void> deleteClient(String clientId) async {
    await _collection.doc(clientId).delete();
  }
}
