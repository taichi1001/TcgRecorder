import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/firestore_share_data.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestoreShareDataRepository =
    Provider.autoDispose<FirestoreShareDataRepository>((ref) => FirestoreShareDataRepository(ref.watch(firestoreServiceProvider)));

final firestoreShareDataGameProvider =
    StreamProvider.autoDispose.family<Game, String>((ref, docName) => ref.watch(firestoreShareDataRepository).getShareGame(docName));

final firestoreShareDataDeckProvider =
    StreamProvider.autoDispose.family<List<Deck>, String>((ref, docName) => ref.watch(firestoreShareDataRepository).getShareDeck(docName));

final firestoreShareDataTagProvider =
    StreamProvider.autoDispose.family<List<Tag>, String>((ref, docName) => ref.watch(firestoreShareDataRepository).getShareTag(docName));

final firestoreShareDataRecordProvider = StreamProvider.autoDispose
    .family<List<Record>, String>((ref, docName) => ref.watch(firestoreShareDataRepository).getShareRecord(docName));

final firestoreShareDataProvider = StreamProvider.autoDispose.family<FirestoreShareData, String>(
  (ref, docName) {
    final gameStream = ref.watch(firestoreShareDataGameProvider(docName).stream);
    final deckStream = ref.watch(firestoreShareDataDeckProvider(docName).stream);
    final tagStream = ref.watch(firestoreShareDataTagProvider(docName).stream);
    final recordStream = ref.watch(firestoreShareDataRecordProvider(docName).stream);

    return Rx.combineLatest4<Game, List<Deck>, List<Tag>, List<Record>, FirestoreShareData>(
      gameStream,
      deckStream,
      tagStream,
      recordStream,
      (game, deckList, tagList, recordList) => FirestoreShareData(
        game: game,
        deckList: deckList,
        tagList: tagList,
        recordList: recordList,
      ),
    );
  },
);

class FirestoreShareDataRepository {
  final FirebaseFirestore _firestore;
  FirestoreShareDataRepository(this._firestore);

  Future initGame(Game game, String user) async {
    final docName = '$user-${game.name}';
    await _firestore.collection('share_data').doc(docName).set(game.toJson());
    await _firestore.collection('share_data').doc(docName).collection('decks').doc('deck0').set({'deck': []});
    await _firestore.collection('share_data').doc(docName).collection('tags').doc('tag0').set({'tag': []});
    await _firestore.collection('share_data').doc(docName).collection('records').doc('record0').set({'record': []});
  }

  Stream<Game> getShareGame(String docName) {
    final userShareDataDoc = _firestore.collection('share_data').doc(docName).snapshots();
    return userShareDataDoc.map((doc) => Game.fromJson(doc.data()!));
  }

  Stream<List<Deck>> getShareDeck(String docName) {
    final deckDataCollection = _firestore.collection('share_data').doc(docName).collection('decks').snapshots();
    List<Deck> deckList = [];
    return deckDataCollection.map(
      (collection) {
        for (final doc in collection.docs) {
          final decks = doc.data()['deck'] as List<dynamic>;
          deckList = [...deckList, ...decks.map((e) => Deck.fromJson(e)).toList()];
        }
        return deckList;
      },
    );
  }

  Stream<List<Tag>> getShareTag(String docName) {
    final tagDataCollection = _firestore.collection('share_data').doc(docName).collection('tags').snapshots();
    List<Tag> tagList = [];
    return tagDataCollection.map(
      (collection) {
        for (final doc in collection.docs) {
          final tags = doc.data()['tag'] as List<dynamic>;
          tagList = [...tagList, ...tags.map((e) => Tag.fromJson(e)).toList()];
        }
        return tagList;
      },
    );
  }

  Stream<List<Record>> getShareRecord(String docName) {
    final recordDataCollection = _firestore.collection('share_data').doc(docName).collection('records').snapshots();
    List<Record> recordList = [];
    return recordDataCollection.map(
      (collection) {
        for (final doc in collection.docs) {
          final records = doc.data()['record'] as List<dynamic>;
          recordList = [...recordList, ...records.map((e) => Record.fromJson(e)).toList()];
        }
        return recordList;
      },
    );
  }
}
