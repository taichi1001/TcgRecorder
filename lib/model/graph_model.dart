import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class GraphModel extends DataGridSource with ChangeNotifier {
  final Game selectedGame;
  List<Record> recordList;
  List<Deck> deckList;
  List<WinRateData> winRateList = [];
  List<DeckDetailData> useDeckDetailList = [];
  List<DeckDetailData> opponentDeckDetailList = [];

  @override
  List<Object> get dataSource => useDeckDetailList;

  final recordRepo = RecordRepo();
  final deckRepo = DeckRepo();

  GraphModel({@required this.selectedGame}) {
    _fetchAll();
  }

  Future _fetchAll() async {
    recordList = await recordRepo.getGameRecord(selectedGame.gameId);
    deckList = await deckRepo.getGameDeck(selectedGame.gameId);
    makeWinRateList();
    makeUseDeckPercentageList();
    makeOpponentDeckPercentageList();
    notifyListeners();
  }

  @override
  Object getCellValue(int rowIndex, String columnName) {
    switch (columnName) {
      case 'deck':
        return useDeckDetailList[rowIndex].deck.deck;
        break;
      case 'matches':
        return useDeckDetailList[rowIndex].matches;
        break;
      case 'win':
        return useDeckDetailList[rowIndex].wins;
        break;
      case 'lose':
        return useDeckDetailList[rowIndex].loses;
        break;
      case 'winRate':
        return useDeckDetailList[rowIndex].winRate;
        break;
      default:
        return ' ';
        break;
    }
  }

  void makeWinRateList() {
    final List<Record> tmpRecordList = [];
    for (final record in recordList) {
      tmpRecordList.add(record);
      final matches = tmpRecordList.length;
      final wins = tmpRecordList.where((record) => record.winOrLose == 1).length;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
      winRateList.add(WinRateData(winRate: winRate, record: record));
    }
  }

  void makeUseDeckPercentageList() {
    for (final deck in deckList) {
      final matches = recordList.where((record) => record.myDeckId == deck.deckId).toList().length;
      if (matches == 0) continue;
      final wins = recordList
          .where((record) => record.myDeckId == deck.deckId)
          .toList()
          .where((record) => record.winOrLose == 1)
          .toList()
          .length;
      final loses = recordList
          .where((record) => record.myDeckId == deck.deckId)
          .toList()
          .where((record) => record.winOrLose == 2)
          .toList()
          .length;
      final useageRate = matches / recordList.length;
      final winRate = wins / matches;
      useDeckDetailList.add(
        DeckDetailData(
          deck: deck,
          matches: matches,
          wins: wins,
          loses: loses,
          useageRate: useageRate,
          winRate: winRate,
        ),
      );
    }
  }

  void makeOpponentDeckPercentageList() {
    for (final deck in deckList) {
      final matches =
          recordList.where((record) => record.opponentDeckId == deck.deckId).toList().length;
      if (matches == 0) continue;
      final wins = recordList
          .where((record) => record.opponentDeckId == deck.deckId)
          .toList()
          .where((record) => record.winOrLose == 1)
          .toList()
          .length;
      final loses = recordList
          .where((record) => record.opponentDeckId == deck.deckId)
          .toList()
          .where((record) => record.winOrLose == 2)
          .toList()
          .length;
      final useageRate = matches / recordList.length;
      final winRate = wins / matches;
      opponentDeckDetailList.add(
        DeckDetailData(
          deck: deck,
          matches: matches,
          wins: wins,
          loses: loses,
          useageRate: useageRate,
          winRate: winRate,
        ),
      );
    }
  }
}

/// 勝率グラフ用のデータクラス
class WinRateData {
  WinRateData({this.winRate, this.record});
  double winRate;
  Record record;
}

/// デッキごとの詳細データ用のデータクラス
class DeckDetailData {
  DeckDetailData(
      {this.deck, this.useageRate, this.winRate, this.wins, this.loses, this.matches, this.color});

  Deck deck;
  double useageRate;
  double winRate;
  int wins;
  int loses;
  int matches;
  Color color;
}
