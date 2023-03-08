import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/firestore_config.dart';
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/share_user.dart';
import 'package:tcg_manager/enum/access_roll.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreShareRepository =
    Provider.autoDispose<FirestoreShareRepository>((ref) => FirestoreShareRepository(ref.watch(firestoreServiceProvider)));

class FirestoreShareRepository {
  final FirebaseFirestore _firestore;
  FirestoreShareRepository(this._firestore);

  Future initGame(Game game, String user) async {
    await _firestore.collection('share_data').doc('$user-${game.name}').set(game.toJson());
    await _firestore.collection('share_data').doc('$user-${game.name}').collection('decks').doc('deck0').set({'deck': []});
    await _firestore.collection('share_data').doc('$user-${game.name}').collection('tags').doc('tag0').set({'tag': []});
    await _firestore.collection('share_data').doc('$user-${game.name}').collection('records').doc('record0').set({'record': []});
    final myself = ShareUser(id: user, roll: AccessRoll.owner);
    final initShare = FirestoreShare(shareUserList: [myself]);
    await _firestore.collection('share').doc('$user-${game.name}').set(initShare.toJson());
  }

  Future<FirestoreConfig> getAll() async {
    final result = await _firestore.collection('config').doc('required_version').get();
    return FirestoreConfig.fromJson(result.data()!);
  }

  List<List<T>> _separateList<T>(List<T> list, int batchSize) {
    List<List<T>> resultList = [];
    for (int i = 0; i < list.length; i += batchSize) {
      int endIndex = (i + batchSize < list.length) ? i + batchSize : list.length;
      resultList.add(list.sublist(i, endIndex));
    }
    return resultList;
  }
}
