import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

final opponentDeckDataByUseDeckProvider = FutureProvider.family.autoDispose<List<WinRateData>, String>(
  (ref, useDeckName) async {
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final gameDeckList = await ref.watch(gameDeckListProvider.future);
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

    final calc = RecordCalculator(targetRecordList: filterRecordList);
    final opponentDeckData = opponentDeckList.map((opponentDeck) {
      final deck = opponentDeck.deck;
      final matchs = calc.countOpponentDeckMatches(useDeck, opponentDeck);
      final win = calc.countOpponentDeckWins(useDeck, opponentDeck);
      final loss = calc.countOpponentDeckLoss(useDeck, opponentDeck);
      final winRate = calc.calcOpponentDeckWinRate(useDeck, opponentDeck);
      final winRateOfFirst = calc.calcOpponentDeckWinRateOfFirst(useDeck, opponentDeck);
      final winRateOfSecond = calc.calcOpponentDeckWinRateOfSecond(useDeck, opponentDeck);
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
        matches: calc.countUseDeckMatches(useDeck),
        win: calc.countUseDeckWins(useDeck),
        loss: calc.countUseDeckLoss(useDeck),
        useRate: calc.calcUseDeckUseRate(useDeck),
        winRate: calc.calcUseDeckWinRate(useDeck),
        winRateOfFirst: calc.calcUseDeckWinRateOfFirst(useDeck),
        winRateOfSecond: calc.calcUseDeckWinRateOfSecond(useDeck),
      ),
    );
    return opponentDeckData;
  },
);
