import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_config.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreConfigRepository =
    Provider.autoDispose<FirestoreConfigRepository>((ref) => FirestoreConfigRepository(ref.watch(firestoreServiceProvider)));

class FirestoreConfigRepository {
  final FirebaseFirestore _firestore;
  FirestoreConfigRepository(this._firestore);

  Future<FirestoreConfig> getAll() async {
    final result = await _firestore.collection('config').doc('required_version').get();
    return FirestoreConfig.fromJson(result.data()!);
  }
}
