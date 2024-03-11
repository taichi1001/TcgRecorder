import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/public_game.dart';
import 'package:tcg_manager/service/firestore.dart';

final firestorePublicGameRepositoryProvider = Provider((ref) => FirestorePublicGameRepository(ref.watch(firestoreServiceProvider)));

final publicGameListProvider = FutureProvider((ref) => ref.watch(firestorePublicGameRepositoryProvider).getAll());

class FirestorePublicGameRepository {
  final FirebaseFirestore _firestore;
  FirestorePublicGameRepository(this._firestore);

  Future<List<PublicGame>> getAll() async {
    final result = await _firestore.collection('public_game').get();
    List<PublicGame> games = [];
    for (var doc in result.docs) {
      var data = doc.data();
      if (data['games'] != null) {
        games.addAll(List<PublicGame>.from(data['games'].map((game) => PublicGame.fromJson(game))));
      }
    }
    return games;
  }
}
