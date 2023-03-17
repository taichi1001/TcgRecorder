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
    await _firestore.collection('counters').doc(docName).set({'deck_counter': 0, 'tag_counter': 0, 'record_counter': 0});
    await _firestore.collection('share_data').doc(docName).set(game.toJson());
    await _firestore.collection('share_data').doc(docName).collection('decks').doc('deck0').set({'deck': [], 'index': 0});
    await _firestore.collection('share_data').doc(docName).collection('tags').doc('tag0').set({'tag': [], 'index': 0});
    await _firestore.collection('share_data').doc(docName).collection('records').doc('record0').set({'record': [], 'index': 0});
  }

  Stream<Game> getShareGame(String docName) {
    final userShareDataDoc = _firestore.collection('share_data').doc(docName).snapshots();
    return userShareDataDoc.map((doc) => Game.fromJson(doc.data()!));
  }

  Future<int> addDeck(Deck deck, String docName) async {
    if (deck.id == null) {
      final newId = await _getNextUniqueIdForShareData(docName, 'deck');
      deck = deck.copyWith(id: newId);
    }
    await _addItem('decks', 'deck', deck.toJson(), docName);
    return deck.id!;
  }

  Future<int> addTag(Tag tag, String docName) async {
    if (tag.id == null) {
      final newId = await _getNextUniqueIdForShareData(docName, 'tag');
      tag = tag.copyWith(id: newId);
    }
    await _addItem('tags', 'tag', tag.toJson(), docName);
    return tag.id!;
  }

  Future<int> addRecord(Record record, String docName) async {
    if (record.recordId == null) {
      final newId = await _getNextUniqueIdForShareData(docName, 'record');
      record = record.copyWith(recordId: newId);
    }
    await _addItem('records', 'record', record.toJson(), docName);
    return record.recordId!;
  }

  Future _addItem(String collectionName, String itemName, Map<String, dynamic> itemData, String docName) async {
    final path = 'share_data/$docName/$collectionName';
    final snapshot = await _firestore.collection(path).orderBy('index', descending: true).limit(1).get();
    if (snapshot.docs.isEmpty) {
      await _firestore.collection(path).doc('${itemName}0').update({
        itemName: FieldValue.arrayUnion([itemData]),
      });
    }
    final lastDoc = snapshot.docs.first;
    final itemList = List.from(lastDoc.data()[itemName]);
    final lastDocIndex = lastDoc.data()['index'];

    if (itemList.length < 500) {
      await _firestore.collection(path).doc('$itemName$lastDocIndex').update({
        itemName: FieldValue.arrayUnion([itemData]),
      });
    } else {
      await _firestore.collection(path).doc('$itemName${lastDocIndex + 1}').set({
        'index': lastDocIndex + 1,
        itemName: [itemData],
      });
    }
  }

  Future<int> _getNextUniqueIdForShareData(String doccName, String itemName) async {
    final counterRef = _firestore.collection('counters').doc(doccName);
    final nextId = await _firestore.runTransaction((transaction) async {
      final counterSnapshot = await transaction.get(counterRef);
      final currentValue = counterSnapshot.data()?['deck_counter'] as int;
      final nextId = currentValue + 1;
      transaction.update(counterRef, {'${itemName}_counter': nextId});
      return nextId;
    });

    return nextId;
  }

  Stream<List<Deck>> getShareDeck(String docName) {
    final deckDataCollection = _firestore.collection('share_data').doc(docName).collection('decks').snapshots();
    return deckDataCollection.map(
      (collection) {
        List<Deck> deckList = [];
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
    return tagDataCollection.map(
      (collection) {
        List<Tag> tagList = [];
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
    return recordDataCollection.map(
      (collection) {
        List<Record> recordList = [];
        for (final doc in collection.docs) {
          final records = doc.data()['record'] as List<dynamic>;
          recordList = [...recordList, ...records.map((e) => Record.fromJson(e)).toList()];
        }
        return recordList;
      },
    );
  }
}
