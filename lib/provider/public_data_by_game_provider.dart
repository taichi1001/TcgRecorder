import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tcg_manager/entity/deck.dart';
import 'package:tcg_manager/entity/record.dart';
import 'package:tcg_manager/entity/win_rate_data.dart';
import 'package:tcg_manager/helper/record_calc.dart';
import 'package:tcg_manager/provider/select_game_provider.dart';
import 'package:tcg_manager/selector/filter_aggregated_data_selector.dart';

import 'package:flutter/foundation.dart';

final publicDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
    final aggregatedData = await ref.watch(filterAggregatedDataProvider(publicGameId!).future);
    final calcResult = await compute(_calculatePublicWinRateData, _CalculationParams(aggregatedData.records, aggregatedData.decks));
    return calcResult;
  },
);

final publicUseRateProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
    final aggregatedData = await ref.watch(filterAggregatedDataProvider(publicGameId!).future);
    final calcResult = await compute(_calculatePublicUseRateData, _CalculationParams(aggregatedData.records, aggregatedData.decks));
    return calcResult;
  },
);

// 変更部分: 別スレッドで実行する関数とパラメータクラスを定義
class _CalculationParams {
  final List<Record> filterRecordList;
  final List<Deck> gameDeckList;

  _CalculationParams(this.filterRecordList, this.gameDeckList);
}

List<WinRateData> _calculatePublicWinRateData(_CalculationParams params) {
  final calc = RecordCalculator(targetRecordList: params.filterRecordList);

  final List<Deck> gameOpponentDeckList = [];
  for (final deck in params.gameDeckList) {
    for (final record in params.filterRecordList) {
      if (record.opponentDeckId == deck.id) {
        gameOpponentDeckList.add(deck);
        break;
      }
    }
  }

  List<WinRateData> winRateDataList = [];
  List<WinRateData> othersList = []; // その他のデータを一時的に保持するリスト
  final totalRecords = params.filterRecordList.length;

  for (final opponentDeck in gameOpponentDeckList) {
    final matches = calc.countOpponentDeckMatches(opponentDeck);
    if (!(matches > totalRecords * 0.01 || matches > 50)) {
      // その他の項目に一時的に追加
      // 集計データの対戦相手のデータを使用デッキのようにみせかけたいため、勝敗を逆にしておく
      othersList.add(WinRateData(
        deck: opponentDeck.name,
        matches: matches,
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
        useRate: 0, // この時点では使用率を計算しない
        winRate: 0, // 勝率も後で計算
        winRateOfFirst: 0, // 先攻勝率も後で計算
        winRateOfSecond: 0, // 後攻勝率も後で計算
      ));
    } else {
      // 通常のWinRateDataオブジェクトを作成してリストに追加
      winRateDataList.add(WinRateData(
        deck: opponentDeck.name,
        matches: matches,
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
      ));
    }
  }

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
    final newOthers = others.copyWith(useRate: others.matches / totalRecords);
    // その他の項目の使用率と勝率を計算
    winRateDataList.add(newOthers);
  }

  return winRateDataList;
}

List<WinRateData> _calculatePublicUseRateData(_CalculationParams params) {
  final calc = RecordCalculator(targetRecordList: params.filterRecordList);

  final List<Deck> gameOpponentDeckList = [];
  for (final deck in params.gameDeckList) {
    for (final record in params.filterRecordList) {
      if (record.opponentDeckId == deck.id) {
        gameOpponentDeckList.add(deck);
        break;
      }
    }
  }

  List<WinRateData> winRateDataList = [];

  for (final opponentDeck in gameOpponentDeckList) {
    // 通常のWinRateDataオブジェクトを作成してリストに追加
    winRateDataList.add(WinRateData(
      deck: opponentDeck.name,
      matches: 0,
      firstMatches: 0,
      secondMatches: 0,
      win: 0,
      firstMatchesWin: 0,
      secondMatchesWin: 0,
      loss: 0,
      firstMatchesLoss: 0,
      secondMatchesLoss: 0,
      draw: 0,
      firstMatchesDraw: 0,
      secondMatchesDraw: 0,
      useRate: calc.calcOpponentDeckUseRate(opponentDeck),
      winRate: 0,
      winRateOfFirst: 0,
      winRateOfSecond: 0,
    ));
  }

  return winRateDataList;
}

final totalAddedToPublicDataByGameProvider = FutureProvider.autoDispose<List<WinRateData>>(
  (ref) async {
    final useDeckDataByGame = [...await ref.watch(publicDataByGameProvider.future)];
    final publicGameId = ref.watch(selectGameNotifierProvider).selectGame!.publicGameId;
    final aggregatedData = await ref.watch(filterAggregatedDataProvider(publicGameId!).future);
    final calc = RecordCalculator(targetRecordList: aggregatedData.records);

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
