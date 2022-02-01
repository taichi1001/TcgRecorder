import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/provider/record_list_provider.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/selector/game_record_list_selector.dart';
import 'package:tcg_manager/state/deck_win_rate_data_state.dart';

class DeckWinRateDataNotifier extends StateNotifier<DeckWinRateDataState> {
  DeckWinRateDataNotifier(this.read) : super(DeckWinRateDataState());

  final Reader read;

  void setWinRateDataList(List<WinRateData> list) {
    state = state.copyWith(winRateDataList: list);
  }
}

final deckWinRateDataNotifierProvider =
    StateNotifierProvider.family.autoDispose<DeckWinRateDataNotifier, DeckWinRateDataState, String>(
  (ref, useDeckName) {
    final gameRecordList = ref.watch(gameRecordListNotifierProvider.select((value) => value.gameRecordList));
    final gameDeckList = ref.watch(gameDeckListProvider);
    final useDeck = gameDeckList.firstWhere((deck) => deck.deck == useDeckName);
    final useDeckRecord = gameRecordList!.where((record) => record.useDeckId == useDeck.deckId).toList();
    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in useDeckRecord) {
        if (record.opponentDeckId == deck.deckId) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    final allRecordListNotifier = ref.read(allRecordListNotifierProvider.notifier);
    final winRateData = opponentDeckList.map((opponentDeck) {
      final deck = opponentDeck.deck;
      final matchs = allRecordListNotifier.countOpponentDeckMatches(useDeck, opponentDeck);
      final win = allRecordListNotifier.countOpponentDeckWins(useDeck, opponentDeck);
      final loss = allRecordListNotifier.countOpponentDeckLoss(useDeck, opponentDeck);
      final winRate = allRecordListNotifier.calcOpponentDeckWinRate(useDeck, opponentDeck);
      final winRateOfFirst = allRecordListNotifier.calcOpponentDeckWinRateOfFirst(useDeck, opponentDeck);
      final winRateOfSecond = allRecordListNotifier.calcOpponentDeckWinRateOfSecond(useDeck, opponentDeck);
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
