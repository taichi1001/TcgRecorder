import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestorePublicUserDataRepository = Provider.autoDispose<FirestorePublicUserDataRepository>(
    (ref) => FirestorePublicUserDataRepository(ref.watch(firestoreServiceProvider)));

class FirestorePublicUserDataRepository {
  final FirebaseFirestore _firestore;
  FirestorePublicUserDataRepository(this._firestore);

  Future init(String user, {int deckCounter = 0, int tagCounter = 0, int recordCounter = 0}) async {
    final docName = user;
    await _firestore.collection('public_user_data').doc(docName).collection('games').doc('games0').set({'games': [], 'index': 0});
    await _firestore.collection('public_user_data').doc(docName).collection('decks').doc('decks0').set({'decks': [], 'index': 0});
    await _firestore.collection('public_user_data').doc(docName).collection('tags').doc('tags0').set({'tags': [], 'index': 0});
    await _firestore.collection('public_user_data').doc(docName).collection('records').doc('records0').set({'records': [], 'index': 0});
  }

  Future<int> addGame(Game game, String docName) async {
    await _addItem('games', game.toJson(), docName);
    return game.id!;
  }

  Future<int> addDeck(Deck deck, String docName) async {
    await _addItem('decks', deck.toJson(), docName);
    return deck.id!;
  }

  Future<int> addTag(Tag tag, String docName) async {
    await _addItem('tags', tag.toJson(), docName);
    return tag.id!;
  }

  Future<int> addRecord(Record record, String docName) async {
    await _addItem('records', record.toJson(), docName);
    return record.id!;
  }

  Future<int> updateGame(Game updateGame, String docName) async {
    await _updateItem('games', docName, 'games', 'game_id', updateGame.toJson());
    return updateGame.id!;
  }

  Future updateDeck(Deck updateDeck, String docName) async {
    await _updateItem('decks', docName, 'decks', 'deck_id', updateDeck.toJson());
  }

  Future updateTag(Tag updateTag, String docName) async {
    await _updateItem('tags', docName, 'tags', 'tag_id', updateTag.toJson());
  }

  Future updateRecord(Record updateRecord, String docName) async {
    await _updateItem('records', docName, 'records', 'record_id', updateRecord.toJson());
  }

  Future removeRecord(Record removeRecord, String docName) async {
    final recordsCollection = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection('records');

    // トランザクションを開始
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await recordsCollection.get();
      for (final snapshot in snapshotList.docs) {
        final List<dynamic> records = snapshot.data()['records'];
        final targetIndex = records.indexWhere((record) => record['record_id'] == removeRecord.id);
        if (targetIndex != -1) {
          records.removeAt(targetIndex);
          transaction.update(snapshot.reference, {'records': records});
          break;
        }
      }
    });
  }

  Future _addItem(String itemName, Map<String, dynamic> itemData, String uid) async {
    final path = 'public_user_data/$uid/$itemName';
    final snapshot = await _firestore.collection(path).orderBy('index', descending: true).limit(1).get();
    late List itemList;
    late int lastDocIndex;

    if (snapshot.docs.isEmpty) {
      DocumentSnapshot docSnap = await _firestore.collection(path).doc('${itemName}0').get();
      if (!docSnap.exists) {
        await init(uid);
      }
      await _firestore.collection(path).doc('${itemName}0').update({
        itemName: FieldValue.arrayUnion([itemData]),
      });
      itemList = [];
      lastDocIndex = 0;
    } else {
      final lastDoc = snapshot.docs.first;
      itemList = List.from(lastDoc.data()[itemName]);
      lastDocIndex = lastDoc.data()['index'];
    }
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

  Future _updateItem(String collectionName, String docName, String fieldName, String idField, Map<String, dynamic> updateData) async {
    final collection = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection(collectionName);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await collection.get();

      for (final snapshot in snapshotList.docs) {
        final List<dynamic> items = snapshot.data()[fieldName];
        final targetIndex = items.indexWhere((item) => item[idField] == updateData[idField]);
        if (targetIndex != -1) {
          items[targetIndex] = updateData;
          transaction.update(snapshot.reference, {fieldName: items});
          break;
        }
      }
    });
  }

  Future _removeItem(String collectionName, String docName, String fieldName, String idField, int? idToRemove) async {
    final collection = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection(collectionName);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await collection.get();

      for (final snapshot in snapshotList.docs) {
        final List<dynamic> items = snapshot.data()[fieldName];
        final targetIndex = items.indexWhere((item) => item[idField] == idToRemove);
        if (targetIndex != -1) {
          items.removeAt(targetIndex);
          transaction.update(snapshot.reference, {fieldName: items});
          break;
        }
      }
    });
  }
}
