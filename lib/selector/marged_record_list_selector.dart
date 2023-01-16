import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/tag.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';

final margedRecordListProvider = FutureProvider.autoDispose<List<MargedRecord>>((ref) async {
  final filterRecordList = await ref.watch(filterRecordListProvider.future);
  final allGameList = await ref.read(allGameListProvider.future);
  final allDeckList = await ref.read(allDeckListProvider.future);
  final allTagList = await ref.read(allTagListProvider.future);

  final list = filterRecordList.map((Record record) {
    final game = allGameList.singleWhere((value) => value.gameId == record.gameId);
    final useDeck = allDeckList.singleWhere((value) => value.deckId == record.useDeckId);
    final opponentDeck = allDeckList.singleWhere((value) => value.deckId == record.opponentDeckId);
    List<Tag> tagList = [];
    for (final tagId in record.tagId) {
      final tag = allTagList.firstWhere((value) => value.tagId == tagId);
      tagList.add(tag);
    }
    return MargedRecord(
      recordId: record.recordId!,
      game: game.game,
      useDeck: useDeck.deck,
      opponentDeck: opponentDeck.deck,
      tag: tagList.map((e) => e.tag).toList(),
      bo: record.bo,
      firstSecond: record.firstSecond,
      firstMatchFirstSecond: record.firstMatchFirstSecond,
      secondMatchFirstSecond: record.secondMatchFirstSecond,
      thirdMatchFirstSecond: record.thiredMatchFirstSecond,
      winLoss: record.winLoss,
      firstMatchWinLoss: record.firstMatchWinLoss,
      secondMatchWinLoss: record.secondMatchWinLoss,
      thirdMatchWinLoss: record.thirdMatchWinLoss,
      date: record.date!,
      memo: record.memo,
      imagePaths: record.imagePath,
    );
  }).toList();
  ref.keepAlive();
  return list;
});

final allMargedRecordListProvider = FutureProvider.autoDispose<List<MargedRecord>>((ref) async {
  final allRecordList = await ref.watch(allRecordListProvider.future);
  final allGameList = await ref.read(allGameListProvider.future);
  final allDeckList = await ref.read(allDeckListProvider.future);
  final allTagList = await ref.read(allTagListProvider.future);

  final list = allRecordList.map((Record record) {
    final game = allGameList.singleWhere((value) => value.gameId == record.gameId);
    final useDeck = allDeckList.singleWhere((value) => value.deckId == record.useDeckId);
    final opponentDeck = allDeckList.singleWhere((value) => value.deckId == record.opponentDeckId);
    final tagList = allTagList.where((value) => value.tagId == record.tagId).toList();
    return MargedRecord(
      recordId: record.recordId!,
      game: game.game,
      useDeck: useDeck.deck,
      opponentDeck: opponentDeck.deck,
      tag: tagList.isEmpty ? [] : [tagList.first.tag],
      bo: record.bo,
      firstSecond: record.firstSecond,
      firstMatchFirstSecond: record.firstMatchFirstSecond,
      secondMatchFirstSecond: record.secondMatchFirstSecond,
      thirdMatchFirstSecond: record.thiredMatchFirstSecond,
      winLoss: record.winLoss,
      firstMatchWinLoss: record.firstMatchWinLoss,
      secondMatchWinLoss: record.secondMatchWinLoss,
      thirdMatchWinLoss: record.thirdMatchWinLoss,
      date: record.date!,
      memo: record.memo,
      imagePaths: record.imagePath,
    );
  }).toList();
  ref.keepAlive();
  return list;
});
