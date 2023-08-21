import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future init(Game game, String user, {int deckCounter = 0, int tagCounter = 0, int recordCounter = 0}) async {
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
    return record.recordId!;
  }

  Future updateRecord(Record updateRecord, String docName) async {
    final recordsCollection = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection('records');

    // トランザクションを開始
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // 各ドキュメントを順番に処理
      final snapshotList = await recordsCollection.get();

      for (final snapshot in snapshotList.docs) {
        final List<dynamic> records = snapshot.data()['records'];

        // 対象のRecordを検索
        final targetIndex = records.indexWhere((record) => record['record_id'] == updateRecord.recordId);

        // 対象のRecordが見つかった場合
        if (targetIndex != -1) {
          // Recordの名前を更新
          records[targetIndex] = updateRecord.toJson();

          // トランザクションでドキュメントを更新
          transaction.update(snapshot.reference, {'records': records});

          // 更新が完了したらループを抜ける
          break;
        }
      }
    });
  }

  Future removeRecord(Record removeRecord, String docName) async {
    final recordsCollection = FirebaseFirestore.instance.collection('public_user_data').doc(docName).collection('records');

    // トランザクションを開始
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      // 各ドキュメントを順番に処理
      final snapshotList = await recordsCollection.get();

      for (final snapshot in snapshotList.docs) {
        final List<dynamic> records = snapshot.data()['records'];

        // 対象のRecordを検索
        final targetIndex = records.indexWhere((record) => record['record_id'] == removeRecord.recordId);

        // 対象のRecordが見つかった場合
        if (targetIndex != -1) {
          // Recordの名前を更新
          records.removeAt(targetIndex);
          // トランザクションでドキュメントを更新
          transaction.update(snapshot.reference, {'records': records});

          // 更新が完了したらループを抜ける
          break;
        }
      }
    });
    if (removeRecord.imagePath != null) {
      for (final imagePath in removeRecord.imagePath!) {
        final strageRef = FirebaseStorage.instance.refFromURL(imagePath);
        await strageRef.delete();
      }
    }
  }

  Future _addItem(String itemName, Map<String, dynamic> itemData, String uid) async {
    final path = 'public_user_data/$uid/$itemName';
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

  Future deleteShareData(String shareDocName) async {
    await _deleteSubCollections(shareDocName, 'decks');
    await _deleteSubCollections(shareDocName, 'tags');
    await _deleteSubCollections(shareDocName, 'records');
    await _firestore.collection('share_data').doc(shareDocName).delete();
  }

  Future _deleteSubCollections(String docName, String targetCollection) async {
    await FirebaseFirestore.instance.collection('public_user_data/$docName/$targetCollection').get().then((querySnapshot) {
      for (final doc in querySnapshot.docs) {
        doc.reference.delete();
      }
    });
  }
}
