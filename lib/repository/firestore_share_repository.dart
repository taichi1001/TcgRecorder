import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreShareRepository =
    Provider.autoDispose<FirestoreShareRepository>((ref) => FirestoreShareRepository(ref.watch(firestoreServiceProvider)));

final hostShareProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getHostShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final guestShareProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getGuestShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final guestPendingShareProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getGuestPendingShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

class FirestoreShareRepository {
  final FirebaseFirestore _firestore;
  FirestoreShareRepository(this._firestore);

  // 新規のゲームをシェアするための関数
  Future initGame(Game game, String user) async {
    final docName = '$user-${game.name}';
    await _firestore.collection('share_data').doc(docName).set(game.toJson());
    await _firestore.collection('share_data').doc(docName).collection('decks').doc('deck0').set({
      'deck': [Deck(name: 'a').toJson()]
    });
    await _firestore.collection('share_data').doc(docName).collection('tags').doc('tag0').set({'tag': []});
    await _firestore.collection('share_data').doc(docName).collection('records').doc('record0').set({'record': []});
    final myself = ShareUser(id: user, roll: AccessRoll.owner);
    final initShare = FirestoreShare(ownerName: user, game: game, shareUserList: [myself], docName: docName);
    await _firestore.collection('share').doc(docName).set(initShare.toJson());
  }

  // ゲーム共有リクエスト
  Future requestDataShare(String shareDirName, ShareUser user) async {
    await _firestore.collection('share').doc(shareDirName).update({
      'pending_user_list': FieldValue.arrayUnion([user.toJson()]),
    });
  }

  // ゲーム共有リクエストを許可する
  Future allowSharing(ShareUser user, String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).update(
      {
        'share_user_list': FieldValue.arrayUnion([user.toJson()]),
        'pending_user_list': FieldValue.arrayRemove([user.toJson()])
      },
    );
  }

  // ゲーム共有リクエストを許可しない
  Future noallowSharing(ShareUser user, String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).update(
      {
        'pending_user_list': FieldValue.arrayRemove([user.toJson()])
      },
    );
  }

  // 共有解除
  Future revokeUser(ShareUser user, String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).update(
      {
        'share_user_list': FieldValue.arrayRemove([user.toJson()]),
      },
    );
  }

  Future deleteShare(String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).delete();
  }

  // シェアフォルダ内の自分がホストになっているゲームの情報を取得する
  Stream<List<FirestoreShare>> getHostShareData(String uid) {
    final userShareCollection = _firestore.collection('share');
    return userShareCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .where(
                (doc) => doc.id.contains(uid),
              )
              .map(
                (doc) => FirestoreShare.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  // シェアフォルダ内の自分がゲストになっているゲームの情報を取得する
  Stream<List<FirestoreShare>> getGuestShareData(String uid) {
    final userShareCollection =
        _firestore.collection('share').where('share_user_list', arrayContains: {'id': uid, 'roll': 'writer'}).snapshots();
    return userShareCollection.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => FirestoreShare.fromJson(doc.data()),
          )
          .toList(),
    );
  }

  // シェアフォルダ内の自分が共有申請中になっているゲームの情報を取得する
  Stream<List<FirestoreShare>> getGuestPendingShareData(String uid) {
    final userShareCollection =
        _firestore.collection('share').where('pending_user_list', arrayContains: {'id': uid, 'roll': 'writer'}).snapshots();
    return userShareCollection.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => FirestoreShare.fromJson(doc.data()),
          )
          .toList(),
    );
  }
}