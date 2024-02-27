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

final hostShareProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getHostShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final guestShareProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getGuestShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final guestPendingShareProvider = StreamProvider.autoDispose<List<FirestoreShare>>(
  (ref) => ref.watch(firestoreShareRepository).getGuestPendingShareData(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final hostShareCountProvider = StreamProvider.autoDispose<int>(
  (ref) => ref.watch(firestoreShareRepository).getCountOfHostShare(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

final guestShareCountProvider = StreamProvider.autoDispose<int>(
  (ref) => ref.watch(firestoreShareRepository).getCountOfGuestShare(ref.read(firebaseAuthNotifierProvider).user!.uid),
);

class FirestoreShareRepository {
  final FirebaseFirestore _firestore;
  FirestoreShareRepository(this._firestore);

  // 新規のゲームをシェアするための関数
  Future<String> initGame(Game game, String user, int? counter) async {
    int gameCounter;
    if (counter == null) {
      gameCounter = await getGameCounter(user);
    } else {
      gameCounter = counter;
    }
    final myself = ShareUser(id: user, roll: AccessRoll.author);
    final initShare = FirestoreShare(authorName: user, game: game.copyWith(id: gameCounter), shareUserList: [myself], docName: '');
    final docRef = await _firestore.collection('share').add(initShare.toJson());
    await docRef.set({'doc_name': docRef.id}, SetOptions(merge: true));
    return docRef.id;
  }

  Future<int> getGameCounter(String user) async {
    final counterRef = FirebaseFirestore.instance.collection('counters').doc(user);

    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(counterRef);

      if (docSnapshot.exists) {
        int currentValue = docSnapshot.data()!['game_counter'] ?? 0;
        transaction.update(counterRef, {'game_counter': currentValue + 1});
        return currentValue + 1;
      } else {
        transaction.set(counterRef, {'game_counter': 1});
        return 1;
      }
    });
  }

  Future updateShare(FirestoreShare share) async {
    await _firestore.collection('share').doc(share.docName).update(share.toJson());
  }

  // ゲーム共有リクエスト
  Future requestDataShare(String shareDirName, ShareUser user) async {
    // ユーザーが既に共有中のユーザーかどうかを確認
    final documentSnapshot = await _firestore.collection('share').doc(shareDirName).get();
    final data = documentSnapshot.data() as Map<String, dynamic>;
    final share = FirestoreShare.fromJson(data);
    final userExists = share.shareUserList.where((element) => element.id == user.id).toList().isNotEmpty;

    if (userExists) {
      throw Exception("ユーザーは既に共有リストに含まれています。");
    } else {
      await _firestore.collection('share').doc(shareDirName).update({
        'pending_user_list': FieldValue.arrayUnion([user.toJson()]),
      });
    }
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

  // ユーザー自身が共有を解除する
  Future revokeUser(ShareUser user, String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).update(
      {
        'share_user_list': FieldValue.arrayRemove([user.toJson()]),
      },
    );
  }

  // ゲームの共有を解除する
  Future disabaledGame(String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).update(
      {
        'is_shared': false,
      },
    );
  }

  Future<bool> updateUserRoll(ShareUser shareUser, AccessRoll newRoll, String shareDocName) async {
    final docRef = FirebaseFirestore.instance.collection('share').doc(shareDocName);

    // トランザクションを使用して整合性を保ちます
    return await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot docSnapshot = await transaction.get(docRef);

      if (docSnapshot.exists) {
        List<dynamic> userList = docSnapshot['share_user_list'];
        bool isUpdated = false;
        // 対象の user_id を持つオブジェクトを探して roll を更新します
        for (int i = 0; i < userList.length; i++) {
          if (userList[i]['id'] == shareUser.id) {
            userList[i]['roll'] = newRoll.name;
            isUpdated = true;
            break;
          }
        }

        // ownerがいなくなる場合にこうしんしないようにする処理
        final ownerList =
            userList.map((e) => ShareUser.fromJson(e)).where((element) => element.roll == AccessRoll.author).toList().toList();
        if (ownerList.isEmpty) return false;

        // 更新された場合のみ、user_list を Firestore に書き込みます
        if (isUpdated) {
          transaction.update(docRef, {'share_user_list': userList});
          return true;
        } else {
          // ユーザーがユーザーリストになかった場合
          return false;
        }
      } else {
        // ドキュメントが見つからなかった場合
        return false;
      }
    });
  }

  // 共有game削除
  Future deleteShare(String shareDocName) async {
    await _firestore.collection('share').doc(shareDocName).delete();
  }

  // シェアフォルダ内の自分がホストになっているゲームの情報を取得する
  Stream<List<FirestoreShare>> getHostShareData(String uid) {
    final userShareCollection =
        _firestore.collection('share').where('is_shared', isEqualTo: true).where('share_user_list', arrayContainsAny: [
      {'id': uid, 'roll': 'author'},
      {'id': uid, 'roll': 'owner'}
    ]).snapshots();
    return userShareCollection.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => FirestoreShare.fromJson(doc.data()),
          )
          .toList(),
    );
  }

  // シェアフォルダ内の自分がホストになっているゲームの個数を取得する
  Stream<int> getCountOfHostShare(String uid) {
    final ref = _firestore.collection('share').where('is_shared', isEqualTo: true).where('share_user_list', arrayContainsAny: [
      {'id': uid, 'roll': 'author'},
      {'id': uid, 'roll': 'owner'}
    ]);
    return ref.snapshots().map((event) => event.size);
  }

  // シェアフォルダ内の自分がゲストになっているゲームの情報を取得する
  Stream<List<FirestoreShare>> getGuestShareData(String uid) {
    final userShareCollection =
        _firestore.collection('share').where('is_shared', isEqualTo: true).where('share_user_list', arrayContainsAny: [
      {'id': uid, 'roll': 'writer'},
      {'id': uid, 'roll': 'reader'},
    ]).snapshots();
    return userShareCollection.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => FirestoreShare.fromJson(doc.data()),
          )
          .toList(),
    );
  }

  // シェアフォルダ内の自分がゲストになっているゲームの個数を取得する
  Stream<int> getCountOfGuestShare(String uid) {
    final ref = _firestore.collection('share').where('is_shared', isEqualTo: true).where('share_user_list', arrayContainsAny: [
      {'id': uid, 'roll': 'writer'},
      {'id': uid, 'roll': 'reader'}
    ]);
    return ref.snapshots().map((event) => event.size);
  }

  // シェアフォルダ内の自分が共有申請中になっているゲームの情報を取得する
  Stream<List<FirestoreShare>> getGuestPendingShareData(String uid) {
    final userShareCollection =
        _firestore.collection('share').where('is_shared', isEqualTo: true).where('pending_user_list', arrayContainsAny: [
      {'id': uid, 'roll': 'writer'},
      {'id': uid, 'roll': 'reader'},
    ]).snapshots();
    return userShareCollection.map(
      (snapshot) => snapshot.docs
          .map(
            (doc) => FirestoreShare.fromJson(doc.data()),
          )
          .toList(),
    );
  }
}
