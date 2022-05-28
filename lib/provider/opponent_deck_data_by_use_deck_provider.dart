import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final opponentDeckDataByUseDeckProvider = StateProvider.family.autoDispose<List<WinRateData>, String>(
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
    final opponentDeckData = opponentDeckList.map((opponentDeck) {
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
    opponentDeckData.add(
      WinRateData(
        deck: '合計',
        matches: filterRecordListNotifier.countUseDeckMatches(useDeck),
        win: filterRecordListNotifier.countUseDeckWins(useDeck),
        loss: filterRecordListNotifier.countUseDeckLoss(useDeck),
        useRate: filterRecordListNotifier.calcUseDeckUseRate(useDeck),
        winRate: filterRecordListNotifier.calcUseDeckWinRate(useDeck),
        winRateOfFirst: filterRecordListNotifier.calcUseDeckWinRateOfFirst(useDeck),
        winRateOfSecond: filterRecordListNotifier.calcUseDeckWinRateOfSecond(useDeck),
      ),
    );
    return opponentDeckData;
  },
);
