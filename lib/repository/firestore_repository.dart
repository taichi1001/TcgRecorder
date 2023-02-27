import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreRepository = Provider.autoDispose<FirestoreRepository>((ref) => FirestoreRepository(ref.watch(firestoreServiceProvider)));

class FirestoreRepository {
  final FirebaseFirestore _firestore;
  FirestoreRepository(this._firestore);

  Future<Map<String, dynamic>?> getAll(String user) async {
    final result = await _firestore.collection('user').doc(user).get();
    return result.exists ? result.data() : null;
  }

  Future<bool> setAll(Map<String, dynamic> data, String user) async {
    await _firestore.collection('user').doc(user).set(data);
    return true;
  }
}
