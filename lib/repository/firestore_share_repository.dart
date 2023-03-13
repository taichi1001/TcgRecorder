import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreShareRepository =
    Provider.autoDispose<FirestoreShareRepository>((ref) => FirestoreShareRepository(ref.watch(firestoreServiceProvider)));

final hostShareDataProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getHostShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final guestShareDataProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getGuestShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

class FirestoreShareRepository {
  final FirebaseFirestore _firestore;
  FirestoreShareRepository(this._firestore);

  // 新規のゲームをシェアするための関数
  Future initGame(Game game, String user) async {
    await _firestore.collection('share_data').doc('$user-${game.name}').set(game.toJson());
    await _firestore.collection('share_data').doc('$user-${game.name}').collection('decks').doc('deck0').set({'deck': []});
    await _firestore.collection('share_data').doc('$user-${game.name}').collection('tags').doc('tag0').set({'tag': []});
    await _firestore.collection('share_data').doc('$user-${game.name}').collection('records').doc('record0').set({'record': []});
    final myself = ShareUser(id: user, roll: AccessRoll.owner);
    final initShare = FirestoreShare(ownerName: user, game: game, shareUserList: [myself]);
    await _firestore.collection('share').doc('$user-${game.name}').set(initShare.toJson());
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

  // シェアフォルダ内の自分が参加しているゲームの情報を取得する
  Stream<List<FirestoreShare>> getGuestShareData(String uid) {
    return _firestore.collection('share').where('share_user_list', arrayContains: uid).snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => FirestoreShare.fromJson(doc.data()),
              )
              .toList(),
        );
  }
}
