import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDao {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getAll(String user) async {
    final result = await _firestore.collection('user').doc(user).get();
    return result.exists ? result.data() : null;
  }

  Future<bool> setAll(Map<String, dynamic> data, String user) async {
    await _firestore.collection('user').doc(user).set(data);
    return true;
  }
}
