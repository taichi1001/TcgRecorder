import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/state/deck_win_rate_data_state.dart';

class DeckWinRateDataNotifier extends StateNotifier<DeckWinRateDataState> {
  DeckWinRateDataNotifier(this.read) : super(DeckWinRateDataState());

  final Reader read;

  void setWinRateDataList(List<WinRateData> list) {
    state = state.copyWith(winRateDataList: list);
  }
}

final deckWinRateDataNotifierProvider = StateNotifierProvider.family.autoDispose<DeckWinRateDataNotifier, DeckWinRateDataState, String>(
  (ref, useDeckName) {
    final filterRecordList = ref.watch(filterRecordListProvider);
    final gameDeckList = ref.watch(gameDeckListProvider);
    final useDeck = gameDeckList.firstWhere((deck) => deck.deck == useDeckName);
    final useDeckRecord = filterRecordList.where((record) => record.useDeckId == useDeck.deckId).toList();
    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in useDeckRecord) {
        if (record.opponentDeckId == deck.deckId) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    final filterRecordListNotifier = ref.read(filterRecordListController);
    final winRateData = opponentDeckList.map((opponentDeck) {
      final deck = opponentDeck.deck;
      final matchs = filterRecordListNotifier.countOpponentDeckMatches(useDeck, opponentDeck);
      final win = filterRecordListNotifier.countOpponentDeckWins(useDeck, opponentDeck);
      final loss = filterRecordListNotifier.countOpponentDeckLoss(useDeck, opponentDeck);
      final winRate = filterRecordListNotifier.calcOpponentDeckWinRate(useDeck, opponentDeck);
      final winRateOfFirst = filterRecordListNotifier.calcOpponentDeckWinRateOfFirst(useDeck, opponentDeck);
      final winRateOfSecond = filterRecordListNotifier.calcOpponentDeckWinRateOfSecond(useDeck, opponentDeck);
      return WinRateData(
        deck: deck,
        matches: matchs,
        win: win,
        loss: loss,
        winRate: winRate,
        winRateOfFirst: winRateOfFirst,
        winRateOfSecond: winRateOfSecond,
      );
    }).toList();

    final deckDataGridNotifier = DeckWinRateDataNotifier(ref.read);
    deckDataGridNotifier.setWinRateDataList(winRateData);
    return deckDataGridNotifier;
  },
);
