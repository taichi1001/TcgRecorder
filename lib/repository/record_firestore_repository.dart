import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/dao/record_firestore_dao.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/firebase_auth_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';

final firestoreRepository = Provider.autoDispose<FirestoreRepository>((ref) => FirestoreRepository(ref));

class FirestoreRepository {
  FirestoreRepository(this.ref);

  final Ref ref;
  final firestoreDao = FirestoreDao();

  Future setAll() async {
    final record = await ref.read(allRecordListProvider.future);
    final deck = await ref.read(allDeckListProvider.future);
    final tag = await ref.read(allTagListProvider.future);
    final game = await ref.read(allGameListProvider.future);
    final user = ref.read(firebaseAuthNotifierProvider).user?.uid;

    if (user != null) {
      await firestoreDao.setAll(
        {
          'game': game.map((e) => e.toJson()).toList(),
          'deck': deck.map((e) => e.toJson()).toList(),
          'tag': tag.map((e) => e.toJson()).toList(),
          'record': record.map((e) => e.toJson()).toList(),
        },
        user,
      );
    }
  }

  Future<bool> restoreAll() async {
    final user = ref.read(firebaseAuthNotifierProvider).user?.uid;
    if (user == null) return false;
    final allData = await firestoreDao.getAll(user);
    if (allData == null) return false;
    final gameJson = allData['game'] as List;
    final gameList = gameJson.map((e) => Game.fromJson(e)).toList();
    final deckJson = allData['deck'] as List;
    final deckList = deckJson.map((e) => Deck.fromJson(e)).toList();
    final tagJson = allData['tag'] as List;
    final tagList = tagJson.map((e) => Tag.fromJson(e)).toList();
    final recordJson = allData['record'] as List;
    final recordList = recordJson.map((e) => Record.fromJson(e)).toList();

    await ref.read(dbHelper).deleteAll();

    await ref.read(gameRepository).insertList(gameList);
    await ref.read(deckRepository).insertList(deckList);
    await ref.read(tagRepository).insertList(tagList);
    await ref.read(recordRepository).insertList(recordList);

    await ref.read(dbHelper).fetchAll();
    return true;
  }
}
