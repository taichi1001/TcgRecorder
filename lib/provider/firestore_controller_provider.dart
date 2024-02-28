import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tcg_manager/entity/firestore_share.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/helper/db_helper.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/firestore_share_data_repository.dart';
import 'package:tcg_manager/repository/firestore_share_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';
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

    final shareDocName = await shareRepository.initGame(game, user, game.id);

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
      maxIdRecord = gameRecordList.reduce((value, element) => element.id! > value.id! ? element : value).id!;
    }
    await shareDataRepository.initGame(
      shareDocName,
      game,
      user,
      deckCounter: maxIdDeck,
      tagCounter: maxIdTag,
      recordCounter: maxIdRecord,
    );
    final futures = <Future>[];
    for (final deck in gameDeckList) {
      futures.add(shareDataRepository.addDeck(deck, shareDocName));
    }
    for (final tag in gameTagList) {
      futures.add(shareDataRepository.addTag(tag, shareDocName));
    }
    for (final record in gameRecordList) {
      if (record.imagePath != null && record.imagePath!.isNotEmpty) {
        List<String> imagePathList = [];
        for (final imagePath in record.imagePath!) {
          final strageRef = FirebaseStorage.instance.ref().child('share_data/$shareDocName/$imagePath');
          final savePath = ref.read(imagePathProvider);
          final file = File('$savePath/$imagePath');
          await strageRef.putFile(file);
          final url = await strageRef.getDownloadURL();
          imagePathList.add(url);
        }
        futures.add(shareDataRepository.addRecord(record.copyWith(imagePath: imagePathList), shareDocName));
      } else {
        futures.add(shareDataRepository.addRecord(record, shareDocName));
      }
    }

    await Future.wait(futures);
  }

  Future revokeGameSharing(FirestoreShare share) async {
    final deckList = await ref.read(firestoreShareDataDeckProvider(share.docName).future);
    final tagList = await ref.read(firestoreShareDataTagProvider(share.docName).future);
    final recordList = await ref.read(firestoreShareDataRecordProvider(share.docName).future);
    if (share.game.id == ref.read(selectGameNotifierProvider).selectGame?.id) {
      ref.read(selectGameNotifierProvider.notifier).changeGame(share.game.copyWith(isShare: false));
    }
    await ref.read(dbHelper).deleteGame(share.game, isRevokeShare: true);
    await ref.read(gameRepository).insert(share.game.copyWith(isShare: false));

    final Map<int, int> deckIdMap = {};
    for (final deck in deckList) {
      final newId = await ref.read(deckRepository).insert(deck.copyWith(id: null));
      deckIdMap[deck.id!] = newId;
    }

    final Map<int, int> tagIdMap = {};
    for (final tag in tagList) {
      final newId = await ref.read(tagRepository).insert(tag.copyWith(id: null));
      tagIdMap[tag.id!] = newId;
    }

    final List<Record> newRecordList = [];
    for (var record in recordList) {
      final newUseDeckId = deckIdMap[record.useDeckId];
      final newOpponentDeckId = deckIdMap[record.opponentDeckId];
      final newTagIdList = record.tagId.map((e) => tagIdMap[e]!).toList();
      record = record.copyWith(useDeckId: newUseDeckId, opponentDeckId: newOpponentDeckId, tagId: newTagIdList);
      if (record.imagePath != null && record.imagePath!.isNotEmpty) {
        final List<String> newImagePath = [];
        var index = 0;
        for (final imagePath in record.imagePath!) {
          final response = await http.get(Uri.parse(imagePath));
          final saveDir = ref.read(imagePathProvider);
          final imageName = 'image_${record.id}_$index';
          final filePath = '$saveDir/$imageName';
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
          newImagePath.add(imageName);
          index++;
        }
        record = record.copyWith(imagePath: newImagePath);
      }
      newRecordList.add(record);
    }
    await ref.read(recordRepository).insertList(newRecordList.map((e) => e.copyWith(id: null)).toList());
    ref.invalidate(allRecordListProvider);
    ref.invalidate(allDeckListProvider);
    ref.invalidate(allTagListProvider);
    ref.invalidate(allGameListProvider);
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
