import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/filter_aggregated_data_selector.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/view/graph_view.dart';

final useDeckDataByOpponentDeckProvider = FutureProvider.family.autoDispose<List<WinRateData>, String>(
  (ref, opponentDeckName) async {
    List<Record> filterRecordList = [];
    List<Deck> gameDeckList = [];
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
    if (isAggregatedData) {
      final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
      final aggregatedData = await ref.watch(filterAggregatedDataProvider(publicGameId!).future);
      filterRecordList = aggregatedData.records;
      gameDeckList = aggregatedData.decks;
    } else {
      filterRecordList = await ref.watch(filterRecordListProvider.future);
      gameDeckList = await ref.watch(gameDeckListProvider.future);
    }

    final opponentDeck = gameDeckList.firstWhere((deck) => deck.name == opponentDeckName);
    final opponenDeckRecord = filterRecordList.where((record) => record.opponentDeckId == opponentDeck.id).toList();
    final List<Deck> useDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in opponenDeckRecord) {
        if (record.useDeckId == deck.id) {
          useDeckList.add(deck);
          break;
        }
      }
    }

    final calc = RecordCalculator(targetRecordList: filterRecordList);
    final useDeckData = useDeckList.map((useDeck) {
      return WinRateData(
        deck: useDeck.name,
        matches: calc.countUseDeckAndOpponentDeckMatches(useDeck, opponentDeck),
        firstMatches: calc.countUseDeckAndOpponentDeckFirstMatches(useDeck, opponentDeck),
        secondMatches: calc.countUseDeckAndOpponentDeckSecondMatches(useDeck, opponentDeck),
        win: calc.countUseDeckAndOpponentDeckWins(useDeck, opponentDeck),
        firstMatchesWin: calc.countUseDeckAndOpponentDeckFirstMatchesWins(useDeck, opponentDeck),
        secondMatchesWin: calc.countUseDeckAndOpponentDeckSecondMatchesWins(useDeck, opponentDeck),
        loss: calc.countUseDeckAndOpponentDeckLoss(useDeck, opponentDeck),
        firstMatchesLoss: calc.countUseDeckAndOpponentDeckFirstMatchesLoss(useDeck, opponentDeck),
        secondMatchesLoss: calc.countUseDeckAndOpponentDeckSecondMatchesLoss(useDeck, opponentDeck),
        draw: calc.countUseDeckAndOpponentDeckDraw(useDeck, opponentDeck),
        firstMatchesDraw: calc.countUseDeckAndOpponentDeckFirstMatchesDraw(useDeck, opponentDeck),
        secondMatchesDraw: calc.countUseDeckAndOpponentDeckSecondMatchesDraw(useDeck, opponentDeck),
        winRate: calc.calcUseDeckAndOpponentDeckWinRate(useDeck, opponentDeck),
        winRateOfFirst: calc.calcUseDeckAndOpponentDeckWinRateOfFirst(useDeck, opponentDeck),
        winRateOfSecond: calc.calcUseDeckAndOpponentDeckWinRateOfSecond(useDeck, opponentDeck),
      );
    }).toList();
    if (isAggregatedData) return useDeckData;
    useDeckData.add(
      WinRateData(
        deck: '合計',
        matches: calc.countUseDeckMatches(opponentDeck),
        firstMatches: calc.countUseDeckFirstMatches(opponentDeck),
        secondMatches: calc.countUseDeckSecondMatches(opponentDeck),
        win: calc.countUseDeckWins(opponentDeck),
        firstMatchesWin: calc.countUseDeckFirstMatchesWins(opponentDeck),
        secondMatchesWin: calc.countUseDeckSecondMatchesWins(opponentDeck),
        loss: calc.countUseDeckLoss(opponentDeck),
        firstMatchesLoss: calc.countUseDeckFirstMatchesLoss(opponentDeck),
        secondMatchesLoss: calc.countUseDeckSecondMatchesLoss(opponentDeck),
        draw: calc.countUseDeckDraw(opponentDeck),
        firstMatchesDraw: calc.countUseDeckFirstMatchesDraw(opponentDeck),
        secondMatchesDraw: calc.countUseDeckSecondMatchesDraw(opponentDeck),
        useRate: calc.calcUseDeckUseRate(opponentDeck),
        winRate: calc.calcUseDeckWinRate(opponentDeck),
        winRateOfFirst: calc.calcUseDeckWinRateOfFirst(opponentDeck),
        winRateOfSecond: calc.calcUseDeckWinRateOfSecond(opponentDeck),
      ),
    );
    return useDeckData;
  },
);
