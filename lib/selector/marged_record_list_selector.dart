import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_recorder2/entity/marged_record.dart';
import 'package:tcg_recorder2/entity/record.dart';
import 'package:tcg_recorder2/provider/deck_list_provider.dart';
import 'package:tcg_recorder2/provider/game_list_provider.dart';
import 'package:tcg_recorder2/provider/record_list_provider.dart';
import 'package:tcg_recorder2/provider/tag_list_provider.dart';

final margedRecordListProvider = StateProvider<List<MargedRecord>>((ref) {
  final allRecordList = ref.watch(allRecordListNotifierProvider).allRecordList;
  final allGameList = ref.read(allGameListNotifierProvider).allGameList;
  final allDeckList = ref.read(allDeckListNotifierProvider).allDeckList;
  final allTagList = ref.read(allTagListNotifierProvider).allTagList;

  if (allRecordList != null && allGameList != null && allDeckList != null && allTagList != null) {
    final list = allRecordList.map((Record record) {
      final game = allGameList.singleWhere((value) => value.gameId == record.gameId);
      final useDeck = allDeckList.singleWhere((value) => value.deckId == record.useDeckId);
      final opponentDeck =
          allDeckList.singleWhere((value) => value.deckId == record.opponentDeckId);
      // final tag = allTagList.singleWhere((value) => value.tagId == record.tagId);
      return MargedRecord(
        recordId: record.recordId!,
        game: game.game,
        useDeck: useDeck.deck,
        opponentDeck: opponentDeck.deck,
        tag: '',
        firstSecond: record.firstSecond,
        winLoss: record.winLoss,
        date: record.date!,
      );
    }).toList();
    return list;
  }
  return List.empty();
});
