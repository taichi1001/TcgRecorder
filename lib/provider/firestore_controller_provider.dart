import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/selector/game_tag_list_selector.dart';

final firestoreControllerProvider = Provider.autoDispose<FirestoreController>((ref) => FirestoreController(ref));

/// Firesore全般の処理や、複数ドキュメントにまたがる処理を行うクラス
class FirestoreController {
  FirestoreController(this.ref);

  final Ref ref;

  Future initShareGame(Game game, String user) async {
    final shareRepository = ref.read(firestoreShareRepository);
    final shareDataRepository = ref.read(firestoreShareDataRepository);

    await shareRepository.initGame(game, user, game.id);

    final gameDeckList = await ref.read(currentGameDeckListProvider(game).future);
    var maxIdDeck = 0;
    if (gameDeckList.isNotEmpty) {
      maxIdDeck = gameDeckList.reduce((value, element) => element.id! > value.id! ? element : value).id!;
    }
    var maxIdTag = 0;
    final gameTagList = await ref.read(currentGameTagListProvider(game).future);
    if (gameTagList.isNotEmpty) {
      maxIdTag = gameTagList.reduce((value, element) => element.id! > value.id! ? element : value).id!;
    }
    var maxIdRecord = 0;
    final gameRecordList = await ref.read(currentGameRecordListProvider(game).future);
    if (gameRecordList.isNotEmpty) {
      maxIdRecord = gameRecordList.reduce((value, element) => element.recordId! > value.recordId! ? element : value).recordId!;
    }
    await shareDataRepository.initGame(
      game,
      user,
      deckCounter: maxIdDeck,
      tagCounter: maxIdTag,
      recordCounter: maxIdRecord,
    );
    final docName = '$user-${game.name}';
    final futures = <Future>[];
    for (final deck in gameDeckList) {
      futures.add(shareDataRepository.addDeck(deck, docName));
    }
    for (final tag in gameTagList) {
      futures.add(shareDataRepository.addTag(tag, docName));
    }
    for (final record in gameRecordList) {
      futures.add(shareDataRepository.addRecord(record, docName));
    }

    await Future.wait(futures);
  }

  Future deleteShareGame(String shareDocName) async {
    final shareRepository = ref.read(firestoreShareRepository);
    final shareDataRepository = ref.read(firestoreShareDataRepository);
    await shareRepository.deleteShare(shareDocName);
    await shareDataRepository.deleteShareData(shareDocName);
    await _deleteAllImage(shareDocName);
  }

  Future _deleteAllImage(String docName) async {
    final firebaseRef = FirebaseStorage.instance.ref().child('share_data/$docName');
    final list = await firebaseRef.listAll();
    for (final item in list.items) {
      await item.delete();
    }
  }
}
