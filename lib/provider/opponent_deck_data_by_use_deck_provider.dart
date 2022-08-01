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
      return WinRateData(
        deck: opponentDeck.deck,
        matches: calc.countOpponentDeckMatches(useDeck, opponentDeck),
        firstMatches: calc.countOpponentDeckFirstMatches(useDeck, opponentDeck),
        secondMatches: calc.countOpponentDeckSecondMatches(useDeck, opponentDeck),
        win: calc.countOpponentDeckWins(useDeck, opponentDeck),
        firstMatchesWin: calc.countOpponentDeckFirstMatchesWins(useDeck, opponentDeck),
        secondMatchesWin: calc.countOpponentDeckSecondMatchesWins(useDeck, opponentDeck),
        loss: calc.countOpponentDeckLoss(useDeck, opponentDeck),
        firstMatchesLoss: calc.countOpponentDeckFirstMatchesLoss(useDeck, opponentDeck),
        secondMatchesLoss: calc.countOpponentDeckSecondMatchesLoss(useDeck, opponentDeck),
        winRate: calc.calcOpponentDeckWinRate(useDeck, opponentDeck),
        winRateOfFirst: calc.calcOpponentDeckWinRateOfFirst(useDeck, opponentDeck),
        winRateOfSecond: calc.calcOpponentDeckWinRateOfSecond(useDeck, opponentDeck),
      );
    }).toList();
    opponentDeckData.add(
      WinRateData(
        deck: '合計',
        matches: calc.countUseDeckMatches(useDeck),
        firstMatches: calc.countUseDeckFirstMatches(useDeck),
        secondMatches: calc.countUseDeckSecondMatches(useDeck),
        win: calc.countUseDeckWins(useDeck),
        firstMatchesWin: calc.countUseDeckFirstMatchesWins(useDeck),
        secondMatchesWin: calc.countUseDeckFirstMatchesLoss(useDeck),
        loss: calc.countUseDeckLoss(useDeck),
        firstMatchesLoss: calc.countUseDeckFirstMatchesLoss(useDeck),
        secondMatchesLoss: calc.countUseDeckSecondMatchesLoss(useDeck),
        useRate: calc.calcUseDeckUseRate(useDeck),
        winRate: calc.calcUseDeckWinRate(useDeck),
        winRateOfFirst: calc.calcUseDeckWinRateOfFirst(useDeck),
        winRateOfSecond: calc.calcUseDeckWinRateOfSecond(useDeck),
      ),
    );
    return opponentDeckData;
  },
);
