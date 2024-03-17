import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/repository/firestore_aggregated_data_repository.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/view/graph_view.dart';

final opponentDeckDataByUseDeckProvider = FutureProvider.family.autoDispose<List<WinRateData>, String>(
  (ref, useDeckName) async {
    List<Record> filterRecordList = [];
    List<Deck> gameDeckList = [];
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
    if (isAggregatedData) {
      final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
      final aggregatedData = await ref.watch(aggregatedDataProvider(publicGameId!).future);
      filterRecordList = aggregatedData.records;
      gameDeckList = aggregatedData.decks;
    } else {
      filterRecordList = await ref.watch(filterRecordListProvider.future);
      gameDeckList = await ref.watch(gameDeckListProvider.future);
    }

    final useDeck = gameDeckList.firstWhere((deck) => deck.name == useDeckName);
    final useDeckRecord = filterRecordList.where((record) => record.useDeckId == useDeck.id).toList();
    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in useDeckRecord) {
        if (record.opponentDeckId == deck.id) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    final calc = RecordCalculator(targetRecordList: filterRecordList);
    final opponentDeckData = opponentDeckList.map((opponentDeck) {
      return WinRateData(
        deck: opponentDeck.name,
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
    opponentDeckData.add(
      WinRateData(
        deck: '合計',
        matches: calc.countUseDeckMatches(useDeck),
        firstMatches: calc.countUseDeckFirstMatches(useDeck),
        secondMatches: calc.countUseDeckSecondMatches(useDeck),
        win: calc.countUseDeckWins(useDeck),
        firstMatchesWin: calc.countUseDeckFirstMatchesWins(useDeck),
        secondMatchesWin: calc.countUseDeckSecondMatchesWins(useDeck),
        loss: calc.countUseDeckLoss(useDeck),
        firstMatchesLoss: calc.countUseDeckFirstMatchesLoss(useDeck),
        secondMatchesLoss: calc.countUseDeckSecondMatchesLoss(useDeck),
        draw: calc.countUseDeckDraw(useDeck),
        firstMatchesDraw: calc.countUseDeckFirstMatchesDraw(useDeck),
        secondMatchesDraw: calc.countUseDeckSecondMatchesDraw(useDeck),
        useRate: calc.calcUseDeckUseRate(useDeck),
        winRate: calc.calcUseDeckWinRate(useDeck),
        winRateOfFirst: calc.calcUseDeckWinRateOfFirst(useDeck),
        winRateOfSecond: calc.calcUseDeckWinRateOfSecond(useDeck),
      ),
    );
    return opponentDeckData;
  },
);
