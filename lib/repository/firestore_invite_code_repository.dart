import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreInviteCodeRepository =
    Provider.autoDispose<FirestoreInviteCodeRepository>((ref) => FirestoreInviteCodeRepository(ref.watch(firestoreServiceProvider), ref));

class FirestoreInviteCodeRepository {
  final Ref ref;
  final FirebaseFirestore _firestore;
  FirestoreInviteCodeRepository(this._firestore, this.ref);

  Future<void> createInviteCode(String targetShareId, String code, {int validHours = 24}) async {
    final expiresAt = DateTime.now().add(Duration(hours: validHours)).toUtc();

    await _firestore.collection('inviteCodes').doc(code).set({
      'code': code,
      'expiresAt': expiresAt,
      'targetShareId': targetShareId,
    });
  }

  Future<String?> validateInviteCode(String code) async {
    final doc = await _firestore.collection('inviteCodes').doc(code).get();

    if (!doc.exists) {
      return null; // コードが存在しない
    }

    final data = doc.data();
    final expiresAt = (data?['expiresAt'] as Timestamp).toDate();
    final targetShareId = data?['targetShareId'] as String;

    if (DateTime.now().toUtc().isAfter(expiresAt)) {
      return null; // 有効期限切れまたはすでに使用済み
    }

    return targetShareId; // コードが有効
  }
}
