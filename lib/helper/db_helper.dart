import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/game.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/repository/deck_repository.dart';
import 'package:tcg_manager/repository/game_repository.dart';
import 'package:tcg_manager/repository/record_repository.dart';
import 'package:tcg_manager/repository/tag_repository.dart';

class DbHelper {
  DbHelper(this.read);
  final Reader read;

  Future deleteAll() async {
    await read(recordRepository).deleteAll();
    await read(tagRepository).deleteAll();
    await read(deckRepository).deleteAll();
    await read(gameRepository).deleteAll();
    await fetchAll();
  }

  Future deleteGame(Game game) async {
    await _deleteGameRecord(game);
    await _deleteGameDeck(game);
    await _deleteGameTag(game);
    await read(gameRepository).deleteById(game.gameId!);
    await fetchAll();
  }

  Future deleteDeck(Deck deck) async {
    await _deleteDeckRecord(deck);
    await read(deckRepository).deleteById(deck.deckId!);
    await fetchAll();
  }

  Future deleteTag(Tag tag) async {
    await _removeTagFromRecord(tag);
    await read(tagRepository).deleteById(tag.tagId!);
    await fetchAll();
  }

  Future _deleteGameRecord(Game game) async {
    final allRecord = read(allRecordListNotifierProvider);
    final gameRecord = allRecord.allRecordList!.where((record) => record.gameId == game.gameId).toList();
    for (final record in gameRecord) {
      await read(recordRepository).deleteById(record.recordId!);
    }
  }

  Future _deleteGameDeck(Game game) async {
    final allDeck = read(allDeckListNotifierProvider);
    final gameDeck = allDeck.allDeckList!.where((deck) => deck.gameId == game.gameId).toList();
    for (final deck in gameDeck) {
      await read(deckRepository).deleteById(deck.deckId!);
    }
  }

  Future _deleteGameTag(Game game) async {
    final allTag = read(allTagListNotifierProvider);
    final gameTag = allTag.allTagList!.where((tag) => tag.gameId == game.gameId).toList();
    for (final tag in gameTag) {
      await read(tagRepository).deleteById(tag.tagId!);
    }
  }

  Future _deleteDeckRecord(Deck deck) async {
    final allRecord = read(allRecordListNotifierProvider);
    final deckRecord =
        allRecord.allRecordList!.where((record) => record.useDeckId == deck.deckId || record.opponentDeckId == deck.deckId).toList();
    for (final record in deckRecord) {
      await read(recordRepository).deleteById(record.recordId!);
    }
  }

  Future _removeTagFromRecord(Tag tag) async {
    final allRecord = read(allRecordListNotifierProvider);
    final tagRecord = allRecord.allRecordList!.where((record) => record.tagId == tag.tagId).toList();
    for (var record in tagRecord) {
      record = record.copyWith(tagId: null);
      await read(recordRepository).update(record);
    }
  }

  Future fetchAll() async {
    await read(allGameListNotifierProvider.notifier).fetch();
    await read(allDeckListNotifierProvider.notifier).fetch();
    await read(allTagListNotifierProvider.notifier).fetch();
    await read(allRecordListNotifierProvider.notifier).fetch();
  }
}

final dbHelper = Provider((ref) => DbHelper(ref.read));
