import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/firestore_backup.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreUserRepository =
    Provider.autoDispose<FirestoreUserRepository>((ref) => FirestoreUserRepository(ref.watch(firestoreServiceProvider)));

class FirestoreUserRepository {
  final FirebaseFirestore _firestore;
  FirestoreUserRepository(this._firestore);

  Future<FirestoreBackup> getAll(String user) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user).get();
    final lastBackupDate = userDoc.exists ? userDoc.data()!['last_backup'] : '';

    final gamesSnapshot = await userDoc.reference.collection('games').get();
    List<Game> gameList = [];
    for (final doc in gamesSnapshot.docs) {
      final games = doc.data()['game'] as List<dynamic>;
      gameList = [...gameList, ...games.map((e) => Game.fromJson(e)).toList()];
    }

    final deckSnapshot = await userDoc.reference.collection('decks').get();
    List<Deck> deckList = [];
    for (final doc in deckSnapshot.docs) {
      final decks = doc.data()['deck'] as List<dynamic>;
      deckList = [...deckList, ...decks.map((e) => Deck.fromJson(e)).toList()];
    }
    final tagSnapshot = await userDoc.reference.collection('tags').get();
    List<Tag> tagList = [];
    for (final doc in tagSnapshot.docs) {
      final tags = doc.data()['tag'] as List<dynamic>;
      tagList = [...tagList, ...tags.map((e) => Tag.fromJson(e)).toList()];
    }

    final recordSnapshot = await userDoc.reference.collection('records').get();
    List<Record> recordList = [];
    for (final doc in recordSnapshot.docs) {
      final records = doc.data()['record'] as List<dynamic>;
      recordList = [...recordList, ...records.map((e) => Record.fromJson(e)).toList()];
    }
    return FirestoreBackup(
      gameList: gameList,
      deckList: deckList,
      tagList: tagList,
      recordList: recordList,
      lastBackup: lastBackupDate.toDate(),
    );
  }

  Future<bool> setAll(FirestoreBackup data, String user) async {
    final separateGameList = _separateList(data.gameList, 500);
    final separateDeckList = _separateList(data.deckList, 500);
    final separateTagList = _separateList(data.tagList, 500);
    final separateRecordList = _separateList(data.recordList, 500);

    await _firestore.collection('users').doc(user).set({'last_backup': data.lastBackup});

    final gameCollectionRef = _firestore.collection('users').doc(user).collection('games');
    await Future.wait(separateGameList.asMap().entries.map((data) async {
      await gameCollectionRef.doc('game${data.key}').set({'game': data.value.map((e) => e.toJson()).toList()});
    }));
    final deckCollectionRef = _firestore.collection('users').doc(user).collection('decks');
    await Future.wait(separateDeckList.asMap().entries.map((data) async {
      await deckCollectionRef.doc('deck${data.key}').set({'deck': data.value.map((e) => e.toJson()).toList()});
    }));
    final tagCollectionRef = _firestore.collection('users').doc(user).collection('tags');
    await Future.wait(separateTagList.asMap().entries.map((data) async {
      await tagCollectionRef.doc('tag${data.key}').set({'tag': data.value.map((e) => e.toJson()).toList()});
    }));
    final recordCollectionRef = _firestore.collection('users').doc(user).collection('records');
    await Future.wait(separateRecordList.asMap().entries.map((data) async {
      await recordCollectionRef.doc('record${data.key}').set({'record': data.value.map((e) => e.toJson()).toList()});
    }));

    return true;
  }

  Future<bool> deleteAll(String user) async {
    await _deleteSubCollections(user, 'games');
    await _deleteSubCollections(user, 'decks');
    await _deleteSubCollections(user, 'tags');
    await _deleteSubCollections(user, 'records');
    await _firestore.collection('users').doc(user).delete();
    return true;
  }

  Future _deleteSubCollections(String user, String targetCollection) async {
    await FirebaseFirestore.instance.collection('users/$user/$targetCollection').get().then((querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
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
