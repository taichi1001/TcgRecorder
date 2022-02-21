import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/state/marged_record_list_state.dart';

class MargedRecordListNotifier extends StateNotifier<MargedRecordListState> {
  MargedRecordListNotifier(this.read) : super(MargedRecordListState());

  final Reader read;

  void setMargedRecordList(List<MargedRecord> list) {
    state = state.copyWith(margedRecordList: list);
  }
}

final margedRecordListProvider =
    StateNotifierProvider.autoDispose<MargedRecordListNotifier, MargedRecordListState>((ref) {
  final margedRecordListNotifier = MargedRecordListNotifier(ref.read);
  final filterRecordList = ref.watch(filterRecordListProvider);
  final allGameList = ref.read(allGameListNotifierProvider).allGameList;
  final allDeckList = ref.read(allDeckListNotifierProvider).allDeckList;
  final allTagList = ref.read(allTagListNotifierProvider).allTagList;

  if (filterRecordList != null && allGameList != null && allDeckList != null && allTagList != null) {
    final list = filterRecordList.map((Record record) {
      final game = allGameList.singleWhere((value) => value.gameId == record.gameId);
      final useDeck = allDeckList.singleWhere((value) => value.deckId == record.useDeckId);
      final opponentDeck = allDeckList.singleWhere((value) => value.deckId == record.opponentDeckId);
      final tagList = allTagList.where((value) => value.tagId == record.tagId).toList();
      return MargedRecord(
        recordId: record.recordId!,
        game: game.game,
        useDeck: useDeck.deck,
        opponentDeck: opponentDeck.deck,
        tag: tagList.isEmpty ? null : tagList.first.tag,
        firstSecond: record.firstSecond,
        winLoss: record.winLoss,
        date: record.date!,
        memo: record.memo,
      );
    }).toList();

    margedRecordListNotifier.setMargedRecordList(list);
    return margedRecordListNotifier;
  }
  margedRecordListNotifier.setMargedRecordList(List.empty());
  return margedRecordListNotifier;
});
