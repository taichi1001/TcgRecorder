import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/marged_record.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/provider/deck_list_provider.dart';
import 'package:tcg_manager/provider/game_list_provider.dart';
import 'package:tcg_manager/provider/tag_list_provider.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/state/marged_record_list_state.dart';

class MargedRecordListNotifier extends StateNotifier<MargedRecordListState> {
  MargedRecordListNotifier(this.read) : super(MargedRecordListState());

  final Reader read;

  void setMargedRecordList(List<MargedRecord> list) {
    state = state.copyWith(margedRecordList: list);
  }

  int countMatches() {
    if (state.margedRecordList != null) {
      return state.margedRecordList!.length;
    }
    return 0;
  }

  int countWins() {
    if (state.margedRecordList != null) {
      return state.margedRecordList!.where((margedRecord) => margedRecord.winLoss == true).length;
    }
    return 0;
  }

  int countLoss() {
    if (state.margedRecordList != null) {
      return state.margedRecordList!.where((margedRecord) => margedRecord.winLoss == false).length;
    }
    return 0;
  }

  double calcWinRate() {
    if (state.margedRecordList != null) {
      final win = countWins();
      final matches = countMatches();
      return win.toDouble() / matches.toDouble();
    }
    return 0;
  }

  double calcWinRateOfFirst() {
    if (state.margedRecordList != null) {
      final firstRecords = state.margedRecordList!.where((margedRecord) => margedRecord.firstSecond == true).toList();
      final win = firstRecords.where((margedRecord) => margedRecord.winLoss == true).length;
      final matches = countMatches();
      return win.toDouble() / matches.toDouble();
    }
    return 0;
  }

  double calcWinRateOfSecond() {
    if (state.margedRecordList != null) {
      final secondRecords = state.margedRecordList!.where((margedRecord) => margedRecord.firstSecond == false).toList();
      final win = secondRecords.where((margedRecord) => margedRecord.winLoss == true).length;
      final matches = countMatches();
      return win.toDouble() / matches.toDouble();
    }
    return 0;
  }
}

final margedRecordListProvider = StateNotifierProvider<MargedRecordListNotifier, MargedRecordListState>((ref) {
  final margedRecordListNotifier = MargedRecordListNotifier(ref.read);
  final selectGameRecordList = ref.watch(gameRecordListNotifierProvider).gameRecordList;
  final allGameList = ref.read(allGameListNotifierProvider).allGameList;
  final allDeckList = ref.read(allDeckListNotifierProvider).allDeckList;
  final allTagList = ref.read(allTagListNotifierProvider).allTagList;

  if (selectGameRecordList != null && allGameList != null && allDeckList != null && allTagList != null) {
    final list = selectGameRecordList.map((Record record) {
      final game = allGameList.singleWhere((value) => value.gameId == record.gameId);
      final useDeck = allDeckList.singleWhere((value) => value.deckId == record.useDeckId);
      final opponentDeck = allDeckList.singleWhere((value) => value.deckId == record.opponentDeckId);
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

    margedRecordListNotifier.setMargedRecordList(list);
    return margedRecordListNotifier;
  }
  margedRecordListNotifier.setMargedRecordList(List.empty());
  return margedRecordListNotifier;
});
