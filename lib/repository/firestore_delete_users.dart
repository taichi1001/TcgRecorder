import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreDeleteUsersRepository =
    Provider.autoDispose<FirestoreDeleteUsersRepository>((ref) => FirestoreDeleteUsersRepository(ref.watch(firestoreServiceProvider)));

class FirestoreDeleteUsersRepository {
  final FirebaseFirestore _firestore;
  FirestoreDeleteUsersRepository(this._firestore);

  Future deleteUser(String uid) async {
    await _firestore.collection('deleted_users').add({'uid': uid, 'createdAt': Timestamp.now()});
  }
}
