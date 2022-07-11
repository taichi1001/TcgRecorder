import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
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
  }

  Future deleteGame(Game game) async {
    await _deleteGameRecord(game);
    await _deleteGameDeck(game);
    await _deleteGameTag(game);
    await ref.read(gameRepository).deleteById(game.gameId!);
    await fetchAll();
  }

  Future deleteDeck(Deck deck) async {
    await _deleteDeckRecord(deck);
    await ref.read(deckRepository).deleteById(deck.deckId!);
    await fetchAll();
  }

  Future deleteTag(Tag tag) async {
    await _removeTagFromRecord(tag);
    await ref.read(tagRepository).deleteById(tag.tagId!);
    await fetchAll();
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
    }
  }

  Future _removeTagFromRecord(Tag tag) async {
    final allRecord = await ref.read(allRecordListProvider.future);
    final tagRecord = allRecord.where((record) => record.tagId == tag.tagId).toList();
    for (var record in tagRecord) {
      record = record.copyWith(tagId: null);
      await ref.read(recordRepository).update(record);
    }
  }

  Future fetchAll() async {
    ref.refresh(allGameListProvider);
    ref.refresh(allDeckListProvider);
    ref.refresh(allTagListProvider);
    ref.refresh(allRecordListProvider);
  }

  Future updateDeckName(String name, int index) async {
    final allDeckList = await ref.read(allDeckListProvider.future);
    final deck = allDeckList[index];
    final newDeck = deck.copyWith(deck: name);
    try {
      await ref.read(deckRepository).update(newDeck);
      ref.refresh(allDeckListProvider);
    } catch (e) {
      rethrow;
    }
  }

  Future updateGameName(String name, int index) async {
    final allGameList = await ref.read(allGameListProvider.future);
    final game = allGameList[index];
    final newGame = game.copyWith(game: name);
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

  Future updateTagName(String name, int index) async {
    final allTagList = await ref.read(allTagListProvider.future);
    final tag = allTagList[index];
    final newTag = tag.copyWith(tag: name);
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
