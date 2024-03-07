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

  Future<void> init(String user) async {
    final docName = user;
    final collections = ['games', 'decks', 'tags', 'records'];
    final data = {'index': 0};

    for (var collection in collections) {
      await _firestore
          .collection('public_user_data')
          .doc(docName)
          .collection(collection)
          .doc('${collection}0')
          .set({collection: [], ...data});
    }
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

  Future removeGame(Game removeGame, String docName) async {
    await _removeItem('games', docName, 'games', 'game_id', removeGame.id);
  }

  Future removeDeck(Deck removeDeck, String docName) async {
    await _removeDeckRecord(removeDeck, docName);
    await _removeItem('decks', docName, 'decks', 'deck_id', removeDeck.id);
  }

  Future removeTag(Tag removeTag, String docName) async {
    await _removeTagFromRecord(removeTag, docName);
    await _removeItem('tags', docName, 'tags', 'tag_id', removeTag.id);
  }

  Future removeRecord(Record removeRecord, String docName) async {
    await _removeItem('records', docName, 'records', 'record_id', removeRecord.id);
  }

  Future _addItem(String itemName, Map<String, dynamic> itemData, String uid) async {
    final path = 'public_user_data/$uid/$itemName';
    final snapshot = await _firestore.collection(path).orderBy('index', descending: true).limit(1).get();
    int lastDocIndex = 0;
    List itemList = [];

    if (snapshot.docs.isNotEmpty) {
      final lastDoc = snapshot.docs.first;
      itemList = List.from(lastDoc.get(itemName));
      lastDocIndex = lastDoc.get('index');
    } else {
      DocumentSnapshot docSnap = await _firestore.collection(path).doc('${itemName}0').get();
      if (!docSnap.exists) {
        await init(uid);
      }
    }

    final documentId = itemList.length < 500 ? '$itemName$lastDocIndex' : '$itemName${lastDocIndex + 1}';
    final updateData = itemList.length < 500
        ? {
            itemName: FieldValue.arrayUnion([itemData])
          }
        : {
            'index': lastDocIndex + 1,
            itemName: [itemData]
          };

    await _firestore.collection(path).doc(documentId).set(updateData, SetOptions(merge: true));
  }

  Future _updateItem(String collectionName, String docName, String fieldName, String idField, Map<String, dynamic> updateData) async {
    final docRef = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection(collectionName);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final querySnapshot = await docRef.get();
      for (var doc in querySnapshot.docs) {
        var items = List<Map<String, dynamic>>.from(doc[fieldName]);
        var itemIndex = items.indexWhere((item) => item[idField] == updateData[idField]);
        if (itemIndex != -1) {
          items[itemIndex] = updateData;
          transaction.update(doc.reference, {fieldName: items});
          break;
        }
      }
    });
  }

  Future _removeItem(String collectionName, String docName, String fieldName, String idField, int? idToRemove) async {
    final docRef = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection(collectionName);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final querySnapshot = await docRef.get();

      for (var doc in querySnapshot.docs) {
        var items = List.from(doc.get(fieldName));
        var itemIndex = items.indexWhere((item) => item[idField] == idToRemove);
        if (itemIndex != -1) {
          items.removeAt(itemIndex);
          transaction.update(doc.reference, {fieldName: items});
          break;
        }
      }
    });
  }

  Future<void> _removeDeckRecord(Deck deck, String docName) async {
    final collection = FirebaseFirestore.instance.collection('share_data').doc(docName).collection('records');
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await collection.get();
      for (final snapshot in snapshotList.docs) {
        final List<dynamic> records = snapshot.get('records');
        final filteredRecords =
            records.where((record) => record['use_deck_id'] != deck.id && record['opponent_deck_id'] != deck.id).toList();
        transaction.update(snapshot.reference, {'records': filteredRecords});
      }
    });
  }

  Future<void> _removeTagFromRecord(Tag tag, String docName) async {
    final collection = FirebaseFirestore.instance.collection('share_data').doc(docName).collection('records');
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await collection.get();
      for (final snapshot in snapshotList.docs) {
        final List<dynamic> records = snapshot.get('records');
        final updatedRecords = records.map((record) {
          final currentRecord = Record.fromJson(record);
          final updatedTagIds = currentRecord.tagId.where((id) => id != tag.id).toList();
          return currentRecord.copyWith(tagId: updatedTagIds).toJson();
        }).toList();
        transaction.update(snapshot.reference, {'records': updatedRecords});
      }
    });
  }
}
