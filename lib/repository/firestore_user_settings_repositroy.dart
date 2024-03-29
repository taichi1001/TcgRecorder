import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/user_data.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreUserSettingsRepository =
    Provider.autoDispose<FirestoreUserSettingsRepository>((ref) => FirestoreUserSettingsRepository(ref.watch(firestoreServiceProvider)));

final userDataListProvider = FutureProvider.autoDispose
    .family<List<UserData>, List<String>>((ref, idList) async => await ref.read(firestoreUserSettingsRepository).getUserFromIdList(idList));

final myUserDataProvider = FutureProvider.autoDispose((ref) async {
  final uid = ref.watch(firebaseAuthNotifierProvider.select((value) => value.user?.uid));
  if (uid == null) return null;
  final userData = await ref.read(firestoreUserSettingsRepository).getUserFromId(uid);
  return userData;
});

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

  Future<UserData?> getUserFromId(String id) async {
    final usersCollection = _firestore.collection('user');
    final userDoc = await usersCollection.doc(id).get();
    return userDoc.data() != null ? UserData.fromJson(userDoc.data()!) : null;
  }

  Future<List<UserData>> getUserFromIdList(List<String> idList) async {
    final usersCollection = _firestore.collection('user');
    List<UserData> userList = [];

    for (final userId in idList) {
      final userDoc = await usersCollection.doc(userId).get();
      userList.add(UserData.fromJson(userDoc.data()!));
    }
    return userList;
  }
}
