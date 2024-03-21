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

import 'package:flutter/foundation.dart';

final useDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
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

    // 変更部分: compute関数を使用して、RecordCalculatorの処理を別スレッドで実行
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
  List<WinRateData> othersList = []; // その他のデータを一時的に保持するリスト
  final totalRecords = params.filterRecordList.length;

  gameUseDeckList.forEach((useDeck) {
    final matches = calc.countUseDeckMatches(useDeck);
    if (matches < totalRecords * 0.01) {
      // その他の項目に一時的に追加
      othersList.add(WinRateData(
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
        useRate: 0, // この時点では使用率を計算しない
        winRate: 0, // 勝率も後で計算
        winRateOfFirst: 0, // 先攻勝率も後で計算
        winRateOfSecond: 0, // 後攻勝率も後で計算
      ));
    } else {
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
  });

  // その他の項目を集計して1つのWinRateDataにまとめる
  if (othersList.isNotEmpty) {
    final others = othersList.reduce((value, element) {
      return WinRateData(
        deck: 'その他',
        matches: value.matches + element.matches,
        firstMatches: value.firstMatches + element.firstMatches,
        secondMatches: value.secondMatches + element.secondMatches,
        win: value.win + element.win,
        firstMatchesWin: value.firstMatchesWin + element.firstMatchesWin,
        secondMatchesWin: value.secondMatchesWin + element.secondMatchesWin,
        loss: value.loss + element.loss,
        firstMatchesLoss: value.firstMatchesLoss + element.firstMatchesLoss,
        secondMatchesLoss: value.secondMatchesLoss + element.secondMatchesLoss,
        draw: value.draw + element.draw,
        firstMatchesDraw: value.firstMatchesDraw + element.firstMatchesDraw,
        secondMatchesDraw: value.secondMatchesDraw + element.secondMatchesDraw,
        useRate: 0, // この時点では使用率を計算しない
      );
    });

    // その他の項目の使用率と勝率を計算
    winRateDataList.add(
      others.copyWith(
        useRate: double.parse(
          (others.matches / totalRecords * 100).toStringAsFixed(1),
        ),
      ),
    );
  }

  return winRateDataList;
}

final totalAddedToUseDeckDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final useDeckDataByGame = [...await ref.watch(useDeckDataByGameProvider.future)];

    List<Record> filterRecordList = [];
    final isAggregatedData = ref.watch(isAggregatedDataProvider);
    if (isAggregatedData) {
      final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
      final aggregatedData = await ref.watch(filterAggregatedDataProvider(publicGameId!).future);
      filterRecordList = aggregatedData.records;
    } else {
      filterRecordList = await ref.watch(filterRecordListProvider.future);
    }

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
