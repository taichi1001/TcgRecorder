import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/filter_aggregated_data_selector.dart';

final publicDataByDeckProvider = FutureProvider.family.autoDispose<List<WinRateData>, String>(
  (ref, useDeckName) async {
    final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
    final aggregatedData = await ref.watch(filterAggregatedDataProvider(publicGameId!).future);
    final filterRecordList = aggregatedData.records;
    final gameDeckList = aggregatedData.decks;

    final opponentDeck = gameDeckList.firstWhere((deck) => deck.name == useDeckName);
    final opponentDeckRecord = filterRecordList.where((record) => record.opponentDeckId == opponentDeck.id).toList();
    final List<Deck> useDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in opponentDeckRecord) {
        if (record.useDeckId == deck.id) {
          useDeckList.add(deck);
          break;
        }
      }
    }

    final calc = RecordCalculator(targetRecordList: filterRecordList);
    final opponentDeckData = useDeckList.map((useDeck) {
      return WinRateData(
        deck: useDeck.name,
        matches: calc.countUseDeckAndOpponentDeckMatches(useDeck, opponentDeck),
        firstMatches: calc.countUseDeckAndOpponentDeckFirstMatches(useDeck, opponentDeck),
        secondMatches: calc.countUseDeckAndOpponentDeckSecondMatches(useDeck, opponentDeck),
        win: calc.countUseDeckAndOpponentDeckLoss(useDeck, opponentDeck),
        firstMatchesWin: calc.countUseDeckAndOpponentDeckFirstMatchesLoss(useDeck, opponentDeck),
        secondMatchesWin: calc.countUseDeckAndOpponentDeckSecondMatchesLoss(useDeck, opponentDeck),
        loss: calc.countUseDeckAndOpponentDeckWins(useDeck, opponentDeck),
        firstMatchesLoss: calc.countUseDeckAndOpponentDeckFirstMatchesWins(useDeck, opponentDeck),
        secondMatchesLoss: calc.countUseDeckAndOpponentDeckSecondMatchesWins(useDeck, opponentDeck),
        draw: calc.countUseDeckAndOpponentDeckDraw(useDeck, opponentDeck),
        firstMatchesDraw: calc.countUseDeckAndOpponentDeckFirstMatchesDraw(useDeck, opponentDeck),
        secondMatchesDraw: calc.countUseDeckAndOpponentDeckSecondMatchesDraw(useDeck, opponentDeck),
        winRate: double.parse(((1 - calc.calcUseDeckAndOpponentDeckWinRate(useDeck, opponentDeck) / 100) * 100).toStringAsFixed(1)),
        winRateOfFirst:
            double.parse(((1 - calc.calcUseDeckAndOpponentDeckWinRateOfFirst(useDeck, opponentDeck) / 100) * 100).toStringAsFixed(1)),
        winRateOfSecond:
            double.parse(((1 - calc.calcUseDeckAndOpponentDeckWinRateOfSecond(useDeck, opponentDeck) / 100) * 100).toStringAsFixed(1)),
      );
    }).toList();
    opponentDeckData.add(
      WinRateData(
        deck: '合計',
        matches: calc.countOpponentDeckMatches(opponentDeck),
        firstMatches: calc.countOpponentDeckFirstMatches(opponentDeck),
        secondMatches: calc.countOpponentDeckSecondMatches(opponentDeck),
        win: calc.countOpponentDeckLoss(opponentDeck),
        firstMatchesWin: calc.countOpponentDeckFirstMatchesLoss(opponentDeck),
        secondMatchesWin: calc.countOpponentDeckSecondMatchesLoss(opponentDeck),
        loss: calc.countOpponentDeckWins(opponentDeck),
        firstMatchesLoss: calc.countOpponentDeckFirstMatchesWins(opponentDeck),
        secondMatchesLoss: calc.countOpponentDeckSecondMatchesWins(opponentDeck),
        draw: calc.countOpponentDeckDraw(opponentDeck),
        firstMatchesDraw: calc.countOpponentDeckFirstMatchesDraw(opponentDeck),
        secondMatchesDraw: calc.countOpponentDeckSecondMatchesDraw(opponentDeck),
        useRate: calc.calcOpponentDeckUseRate(opponentDeck),
        winRate: double.parse(((1 - calc.calcOpponentDeckWinRate(opponentDeck) / 100) * 100).toStringAsFixed(1)),
        winRateOfFirst: double.parse(((1 - calc.calcOpponentDeckWinRateOfFirst(opponentDeck) / 100) * 100).toStringAsFixed(1)),
        winRateOfSecond: double.parse(((1 - calc.calcOpponentDeckWinRateOfSecond(opponentDeck) / 100) * 100).toStringAsFixed(1)),
      ),
    );
    return opponentDeckData;
  },
);
