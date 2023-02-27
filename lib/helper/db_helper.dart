// ignore_for_file: unrelated_type_equality_checks, unused_result

import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/main.dart';
import 'package:tcg_manager/provider/backup_provider.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/provider/firestore_controller.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';

class DbHelper {
  DbHelper(this.ref);
  final ProviderRef ref;

  Future deleteAll() async {
    await ref.read(recordRepository).deleteAll();
    await ref.read(tagRepository).deleteAll();
    await ref.read(deckRepository).deleteAll();
    await ref.read(gameRepository).deleteAll();
    await fetchAll();
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).setAll();
  }

  Future deleteGame(Game game) async {
    await _deleteGameRecord(game);
    await _deleteGameDeck(game);
    await _deleteGameTag(game);
    await ref.read(gameRepository).deleteById(game.gameId!);
    await fetchAll();
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).setAll();
  }

  Future deleteDeck(Deck deck) async {
    await _deleteDeckRecord(deck);
    await ref.read(deckRepository).deleteById(deck.deckId!);
    await fetchAll();
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).setAll();
  }

  Future deleteTag(Tag tag) async {
    await _removeTagFromRecord(tag);
    await ref.read(tagRepository).deleteById(tag.tagId!);
    await fetchAll();
    if (ref.read(backupNotifierProvider)) await ref.read(firestoreController).setAll();
  }

  Future _deleteGameRecord(Game game) async {
    final allRecord = await ref.read(allRecordListProvider.future);
    final gameRecord = allRecord.where((record) => record.gameId == game.gameId).toList();
    for (final record in gameRecord) {
      await ref.read(recordRepository).deleteById(record.recordId!);
    }
  }

  Future _deleteGameDeck(Game game) async {
    final allDeck = await ref.read(allDeckListProvider.future);
    final gameDeck = allDeck.where((deck) => deck.gameId == game.gameId).toList();
    for (final deck in gameDeck) {
      await ref.read(deckRepository).deleteById(deck.deckId!);
    }
  }

  Future _deleteGameTag(Game game) async {
    final allTag = await ref.read(allTagListProvider.future);
    final gameTag = allTag.where((tag) => tag.gameId == game.gameId).toList();
    for (final tag in gameTag) {
      await ref.read(tagRepository).deleteById(tag.tagId!);
    }
  }

  Future _deleteDeckRecord(Deck deck) async {
    final allRecord = await ref.read(allRecordListProvider.future);
    final deckRecord = allRecord.where((record) => record.useDeckId == deck.deckId || record.opponentDeckId == deck.deckId).toList();
    for (final record in deckRecord) {
      await ref.read(recordRepository).deleteById(record.recordId!);
      removeRecordImage(record);
    }
  }

  Future _removeTagFromRecord(Tag tag) async {
    final allRecord = await ref.read(allRecordListProvider.future);
    final tagRecord = allRecord.where((record) => record.tagId == tag.tagId).toList();
    for (var record in tagRecord) {
      record = record.copyWith(tagId: []);
      await ref.read(recordRepository).update(record);
    }
  }

  void removeRecordImage(Record record) {
    if (record.imagePath == null) return;
    final appPath = ref.read(imagePathProvider);
    for (final path in record.imagePath!) {
      final dir = Directory('$appPath/$path');
      dir.deleteSync(recursive: true);
    }
  }

  Future fetchAll() async {
    ref.refresh(allGameListProvider);
    ref.refresh(allDeckListProvider);
    ref.refresh(allTagListProvider);
    ref.refresh(allRecordListProvider);
  }

  Future updateDeckName(Deck deck, String newName) async {
    final newDeck = deck.copyWith(deck: newName);
    try {
      await ref.read(deckRepository).update(newDeck);
      ref.refresh(allDeckListProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future updateGameName(Game game, String newName) async {
    final newGame = game.copyWith(game: newName);
    try {
      await ref.read(gameRepository).update(newGame);
      ref.refresh(allGameListProvider);
      // 編集したゲームがselectGameと同じだった場合の処理
      if (ref.read(selectGameNotifierProvider).selectGame!.gameId == newGame.gameId) {
        ref.read(selectGameNotifierProvider.notifier).changeGame(newGame);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateTagName(Tag tag, String newName) async {
    final newTag = tag.copyWith(tag: newName);
    try {
      await ref.read(tagRepository).update(newTag);
      ref.refresh(allTagListProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future toggleIsVisibleToPickerOfDeck(Deck deck) async {
    final newDeck = deck.copyWith(isVisibleToPicker: !deck.isVisibleToPicker);
    await ref.read(deckRepository).update(newDeck);
    ref.refresh(allDeckListProvider);
  }

  Future toggleIsVisibleToPickerOfTag(Tag tag) async {
    final newTag = tag.copyWith(isVisibleToPicker: !tag.isVisibleToPicker);
    await ref.read(tagRepository).update(newTag);
    ref.refresh(allTagListProvider);
  }
}

final dbHelper = Provider((ref) => DbHelper(ref));
