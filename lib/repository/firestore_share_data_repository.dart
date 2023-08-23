import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
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

class FirestoreShareDataRepository {
  final FirebaseFirestore _firestore;
  FirestoreShareDataRepository(this._firestore);

  Future initGame(Game game, String user, {int deckCounter = 0, int tagCounter = 0, int recordCounter = 0}) async {
    final docName = '$user-${game.name}';
    final gameCounter = await getGameCounter(user);
    await _firestore
        .collection('counters')
        .doc(docName)
        .set({'deck_counter': deckCounter, 'tag_counter': tagCounter, 'record_counter': recordCounter});
    await _firestore.collection('share_data').doc(docName).set(game.copyWith(id: gameCounter).toJson());
    await _firestore.collection('share_data').doc(docName).collection('decks').doc('decks0').set({'decks': [], 'index': 0});
    await _firestore.collection('share_data').doc(docName).collection('tags').doc('tags0').set({'tags': [], 'index': 0});
    await _firestore.collection('share_data').doc(docName).collection('records').doc('records0').set({'records': [], 'index': 0});
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

  Stream<Game> getShareGame(String docName) {
    final userShareDataDoc = _firestore.collection('share_data').doc(docName).snapshots();
    return userShareDataDoc.map((doc) => Game.fromJson(doc.data()!));
  }

  Future<int> addDeck(Deck deck, String docName) async {
    if (deck.id == null) {
      final newId = await _getNextUniqueIdForShareData(docName, 'deck');
      deck = deck.copyWith(id: newId);
    }
    await _addItem('decks', deck.toJson(), docName);
    return deck.id!;
  }

  Future<int> addTag(Tag tag, String docName) async {
    if (tag.id == null) {
      final newId = await _getNextUniqueIdForShareData(docName, 'tag');
      tag = tag.copyWith(id: newId);
    }
    await _addItem('tags', tag.toJson(), docName);
    return tag.id!;
  }

  Future<int> addRecord(Record record, String docName) async {
    if (record.id == null) {
      final newId = await _getNextUniqueIdForShareData(docName, 'record');
      record = record.copyWith(id: newId);
    }
    await _addItem('records', record.toJson(), docName);
    return record.id!;
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
    await _removeImages(removeRecord.imagePath);
  }

  Future _addItem(String itemName, Map<String, dynamic> itemData, String docName) async {
    final path = 'share_data/$docName/$itemName';
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

  Future _updateItem(String collectionName, String docName, String fieldName, String idField, Map<String, dynamic> updateData) async {
    final collection = FirebaseFirestore.instance.collection('share_data').doc(docName).collection(collectionName);

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
    final collection = FirebaseFirestore.instance.collection('share_data').doc(docName).collection(collectionName);

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

  Future _removeDeckRecord(Deck deck, String docName) async {
    final collection = FirebaseFirestore.instance.collection('share_data').doc(docName).collection('records');
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await collection.get();
      for (final snapshot in snapshotList.docs) {
        final List<dynamic> items = snapshot.data()['records'];
        final itemsTmp = [...items];
        var index = 0;
        for (final item in items) {
          if (item['use_deck_id'] == deck.id || item['opponent_deck_id'] == deck.id) {
            itemsTmp.removeAt(index);
            index--;
          }
          index++;
        }
        transaction.update(snapshot.reference, {'records': itemsTmp});
      }
    });
  }

  Future _removeTagFromRecord(Tag tag, String docName) async {
    final collection = FirebaseFirestore.instance.collection('share_data').doc(docName).collection('records');

    // トランザクション開始
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshotList = await collection.get();

      for (final snapshot in snapshotList.docs) {
        final List<dynamic> items = snapshot.data()['records'];
        final newRecords = items.map((item) {
          final record = Record.fromJson(item);
          // tagIdがimmutableな場合、新しいtagIdのリストを作成し、copyWithを使用して新しいレコードインスタンスを作成します。
          final newTagId = List.of(record.tagId)..removeWhere((element) => element == tag.id);
          final newRecord = record.copyWith(tagId: newTagId);
          return newRecord.toJson();
        }).toList();

        // 更新
        transaction.update(snapshot.reference, {'records': newRecords});
      }
    });
  }

  Future _removeImages(List<String>? imagePaths) async {
    if (imagePaths != null) {
      for (final imagePath in imagePaths) {
        final storageRef = FirebaseStorage.instance.refFromURL(imagePath);
        await storageRef.delete();
      }
    }
  }

  Future<int> _getNextUniqueIdForShareData(String doccName, String itemName) async {
    final counterRef = _firestore.collection('counters').doc(doccName);
    final nextId = await _firestore.runTransaction((transaction) async {
      final counterSnapshot = await transaction.get(counterRef);
      final currentValue = counterSnapshot.data()?['${itemName}_counter'] as int;
      final nextId = currentValue + 1;
      transaction.update(counterRef, {'${itemName}_counter': nextId});
      return nextId;
    });

    return nextId;
  }

  Stream<List<T>> getSharedItems<T>(String docName, String collectionName, T Function(Map<String, dynamic>) fromJson) {
    final dataCollection = _firestore.collection('share_data').doc(docName).collection(collectionName).snapshots();
    return dataCollection.map(
      (collection) {
        List<T> itemList = [];
        for (final doc in collection.docs) {
          final items = doc.data()[collectionName] as List<dynamic>;
          itemList = [...itemList, ...items.map((e) => fromJson(e)).toList()];
        }
        return itemList;
      },
    );
  }

  Stream<List<Deck>> getShareDeck(String docName) {
    return getSharedItems<Deck>(docName, 'decks', (data) => Deck.fromJson(data));
  }

  Stream<List<Tag>> getShareTag(String docName) {
    return getSharedItems<Tag>(docName, 'tags', (data) => Tag.fromJson(data));
  }

  Stream<List<Record>> getShareRecord(String docName) {
    return getSharedItems<Record>(docName, 'records', (data) => Record.fromJson(data));
  }

  Future deleteShareData(String shareDocName) async {
    await _deleteSubCollections(shareDocName, 'decks');
    await _deleteSubCollections(shareDocName, 'tags');
    await _deleteSubCollections(shareDocName, 'records');
    await _firestore.collection('share_data').doc(shareDocName).delete();
  }

  Future _deleteSubCollections(String docName, String targetCollection) async {
    await FirebaseFirestore.instance.collection('share_data/$docName/$targetCollection').get().then((querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}
