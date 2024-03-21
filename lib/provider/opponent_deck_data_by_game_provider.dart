import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/filter_aggregated_data_selector.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';
import 'package:tcg_manager/view/data_view/data_view.dart';

final opponentDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
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

    final calc = RecordCalculator(targetRecordList: filterRecordList);

    final List<Deck> opponentDeckList = [];
    for (final deck in gameDeckList) {
      for (final record in filterRecordList) {
        if (record.opponentDeckId == deck.id) {
          opponentDeckList.add(deck);
          break;
        }
      }
    }

    return opponentDeckList
        .map(
          (opponentDeck) => WinRateData(
            deck: opponentDeck.name,
            matches: calc.countOpponentDeckMatches(opponentDeck),
            firstMatches: calc.countOpponentDeckFirstMatches(opponentDeck),
            secondMatches: calc.countOpponentDeckSecondMatches(opponentDeck),
            win: calc.countOpponentDeckWins(opponentDeck),
            firstMatchesWin: calc.countOpponentDeckFirstMatchesWins(opponentDeck),
            secondMatchesWin: calc.countOpponentDeckSecondMatchesWins(opponentDeck),
            loss: calc.countOpponentDeckLoss(opponentDeck),
            firstMatchesLoss: calc.countOpponentDeckFirstMatchesLoss(opponentDeck),
            secondMatchesLoss: calc.countOpponentDeckSecondMatchesLoss(opponentDeck),
            draw: calc.countOpponentDeckDraw(opponentDeck),
            firstMatchesDraw: calc.countOpponentDeckFirstMatchesDraw(opponentDeck),
            secondMatchesDraw: calc.countOpponentDeckSecondMatchesDraw(opponentDeck),
            useRate: calc.calcOpponentDeckUseRate(opponentDeck),
            winRate: calc.calcOpponentDeckWinRate(opponentDeck),
            winRateOfFirst: calc.calcOpponentDeckWinRateOfFirst(opponentDeck),
            winRateOfSecond: calc.calcOpponentDeckWinRateOfSecond(opponentDeck),
          ),
        )
        .toList();
  },
);

final totalAddedToOpponentDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
    final opponentDeckDataByGame = [...await ref.watch(opponentDeckDataByGameProvider.future)];
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final calc = RecordCalculator(targetRecordList: filterRecordList);
    if (isAggregatedData) return opponentDeckDataByGame;
    opponentDeckDataByGame.add(
      WinRateData(
        deck: '合計',
        matches: calc.countMatches(),
        firstMatches: calc.countFirstMatches(),
        secondMatches: calc.countSecondMatches(),
        win: calc.countWins(),
        firstMatchesWin: calc.countFirstMatchesWins(),
        secondMatchesWin: calc.countSecondMatchesWins(),
        loss: calc.countLoss(),
        firstMatchesLoss: calc.countFirstMatchesLoss(),
        secondMatchesLoss: calc.countSecondMatchesLoss(),
        draw: calc.countDraw(),
        firstMatchesDraw: calc.countFirstMatchesDraw(),
        secondMatchesDraw: calc.countSecondMatchesDraw(),
        winRate: calc.calcWinRate(),
        winRateOfFirst: calc.calcWinRateOfFirst(),
        winRateOfSecond: calc.calcWinRateOfSecond(),
      ),
    );
    return opponentDeckDataByGame;
  },
);
