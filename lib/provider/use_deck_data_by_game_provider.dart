import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/selector/filter_record_list_selector.dart';
import 'package:tcg_manager/selector/game_deck_list_selector.dart';

import 'package:flutter/foundation.dart';

final useDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final gameDeckList = await ref.watch(gameDeckListProvider.future);
    final calcResults = await compute(_calculateWinRateData, _CalculationParams(filterRecordList.toList(), gameDeckList));

    return calcResults;
  },
);

// 変更部分: 別スレッドで実行する関数とパラメータクラスを定義
class _CalculationParams {
  final List<Record> filterRecordList;
  final List<Deck> gameDeckList;

  _CalculationParams(this.filterRecordList, this.gameDeckList);
}

List<WinRateData> _calculateWinRateData(_CalculationParams params) {
  final calc = RecordCalculator(targetRecordList: params.filterRecordList);

  final List<Deck> gameUseDeckList = [];
  for (final deck in params.gameDeckList) {
    for (final record in params.filterRecordList) {
      if (record.useDeckId == deck.id) {
        gameUseDeckList.add(deck);
        break;
      }
    }
  }

  List<WinRateData> winRateDataList = [];
  for (var useDeck in gameUseDeckList) {
    final matches = calc.countUseDeckMatches(useDeck);

    // 通常のWinRateDataオブジェクトを作成してリストに追加
    winRateDataList.add(WinRateData(
      deck: useDeck.name,
      matches: matches,
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
    ));
  }

  return winRateDataList;
}

final totalAddedToUseDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final useDeckDataByGame = [...await ref.watch(useDeckDataByGameProvider.future)];
    final filterRecordList = await ref.watch(filterRecordListProvider.future);
    final calc = RecordCalculator(targetRecordList: filterRecordList);

    useDeckDataByGame.add(
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
    return useDeckDataByGame;
  },
);
