import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/service/firestore.dart';

final aggregatedDataProvider =
    FutureProvider.family<AggregatedData, int>((ref, id) => ref.read(firestoreAggregatedDataRepositoryProvider).getAggregatedData(id));

final firestoreAggregatedDataRepositoryProvider = Provider((ref) => FirestoreAggregatedDataRepository(ref.watch(firestoreServiceProvider)));

class AggregatedData {
  final List<Deck> decks;
  final List<Tag> tags;
  final List<Record> records;

  AggregatedData({
    required this.decks,
    required this.tags,
    required this.records,
  });
}

class FirestoreAggregatedDataRepository {
  final FirebaseFirestore _firestore;

  FirestoreAggregatedDataRepository(this._firestore);

  Future<AggregatedData> getAggregatedData(int id) async {
    final resultDecks = await _firestore.collection('aggregated_data').doc(id.toString()).collection('decks').get();
    final resultTags = await _firestore.collection('aggregated_data').doc(id.toString()).collection('tags').get();
    final resultRecords = await _firestore.collection('aggregated_data').doc(id.toString()).collection('records').get();

    return AggregatedData(
      decks: resultDecks.docs
          .map((doc) => (doc.data()['decks'] as List).map((deck) => Deck.fromJson(deck as Map<String, dynamic>)).toList())
          .expand((i) => i)
          .toList(),
      tags: resultTags.docs
          .map((doc) => (doc.data()['tags'] as List).map((tag) => Tag.fromJson(tag as Map<String, dynamic>)).toList())
          .expand((i) => i)
          .toList(),
      records: resultRecords.docs
          .map((doc) => (doc.data()['records'] as List).map((record) => Record.fromJson(record as Map<String, dynamic>)).toList())
          .expand((i) => i)
          .toList(),
    );
  }
}
