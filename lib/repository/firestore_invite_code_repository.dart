import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreInviteCodeRepository =
    Provider.autoDispose<FirestoreInviteCodeRepository>((ref) => FirestoreInviteCodeRepository(ref.watch(firestoreServiceProvider), ref));

class InviteCode {
  InviteCode({
    required this.code,
    required this.expiresAt,
    required this.targetShareId,
  });
  final String code;
  final DateTime expiresAt;
  final String targetShareId;
}

class FirestoreInviteCodeRepository {
  final Ref ref;
  final FirebaseFirestore _firestore;
  FirestoreInviteCodeRepository(this._firestore, this.ref);

  String _generateInviteCode(int length) {
    const String chars = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789'; // 紛らわしい文字I, l, 1, O, 0を除外
    Random rnd = Random();

    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  Future<InviteCode> createInviteCode(String targetShareId, {int validHours = 24}) async {
    // 現在の時刻を取得
    final now = DateTime.now().toUtc();

    // targetShareIdが既に存在するドキュメントを検索
    final existingQuerySnapshot = await _firestore.collection('inviteCodes').where('targetShareId', isEqualTo: targetShareId).get();

    for (var doc in existingQuerySnapshot.docs) {
      final data = doc.data();
      final expiresAt = (data['expiresAt'] as Timestamp).toDate();
      // 有効期限が過ぎていれば、そのドキュメントを削除
      if (expiresAt.isBefore(now)) {
        await doc.reference.delete();
      } else {
        // 有効期限内であれば、そのドキュメントのcodeを返す
        return InviteCode(code: data['code'], expiresAt: expiresAt, targetShareId: targetShareId);
      }
    }

    // 新しい招待コードを生成
    DateTime expiresAt = now.add(Duration(hours: validHours));
    bool isUnique = false;
    String code; // この変数のスコープをwhileループの外に移動

    do {
      code = _generateInviteCode(6);
      final querySnapshot = await _firestore.collection('inviteCodes').where('code', isEqualTo: code).get();
      isUnique = querySnapshot.docs.isEmpty;

      if (isUnique) {
        await _firestore.collection('inviteCodes').add({
          'code': code,
          'expiresAt': expiresAt,
          'targetShareId': targetShareId,
        });
      }
    } while (!isUnique);

    return InviteCode(code: code, expiresAt: expiresAt, targetShareId: targetShareId);
  }

  Future<String?> validateInviteCode(String code) async {
    // 招待コードに基づいてドキュメントを検索
    final querySnapshot = await _firestore.collection('inviteCodes').where('code', isEqualTo: code).get();

    if (querySnapshot.docs.isEmpty) {
      return null; // コードが存在しない
    }

    // 最初のドキュメントを取得（理論上はユニークな招待コードのため、1つのみ存在します）
    final doc = querySnapshot.docs.first;
    final data = doc.data();
    final expiresAt = (data['expiresAt'] as Timestamp).toDate();
    final targetShareId = data['targetShareId'] as String;

    if (DateTime.now().toUtc().isAfter(expiresAt)) {
      return null; // 有効期限切れ
    }

    return targetShareId; // コードが有効
  }
}
