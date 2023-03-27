import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/user_data.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreUserSettingsRepository =
    Provider.autoDispose<FirestoreUserSettingsRepository>((ref) => FirestoreUserSettingsRepository(ref.watch(firestoreServiceProvider)));

class FirestoreUserSettingsRepository {
  final FirebaseFirestore _firestore;
  FirestoreUserSettingsRepository(this._firestore);

  Future<UserData> getAll(String uid) async {
    final result = await _firestore.collection('user').doc(uid).get();
    if (result.data() != null) {
      return UserData.fromJson(result.data()!);
    }
    return UserData(id: uid);
  }

  Future setAll(UserData userData) async {
    await _firestore.collection('user').doc(userData.id).set(userData.toJson());
  }
}
