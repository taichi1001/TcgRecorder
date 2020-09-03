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
  List<DeckPercentageData> useDeckPercentageList = [];
  List<DeckPercentageData> opponentDeckPercentageList = [];

  @override
  List<Object> get dataSource => useDeckPercentageList;

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

  void notify() {
    notifyListeners();
  }

  @override
  Object getCellValue(int rowIndex, String columnName) {
    switch (columnName) {
      case 'deck':
        return useDeckPercentageList[rowIndex].deck.deck;
        break;
      case 'count':
        return useDeckPercentageList[rowIndex].count;
        break;
      case 'win':
        return useDeckPercentageList[rowIndex].wins;
        break;
      case 'lose':
        return useDeckPercentageList[rowIndex].loses;
        break;
      case 'percentage':
        return useDeckPercentageList[rowIndex].winRate;
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
      final wins =
          tmpRecordList.where((record) => record.winOrLose == 1).length;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
      winRateList.add(WinRateData(winRate: winRate, record: record));
    }
  }

  void makeUseDeckPercentageList() {
    for (final deck in deckList) {
      final percentage = recordList
              .where((record) => record.myDeckId == deck.deckId)
              .toList()
              .length /
          recordList.length;
      if (percentage != 0) {
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
        final deckCount = recordList
            .where((record) => record.myDeckId == deck.deckId)
            .toList()
            .length;
        final winRate = wins /
            recordList
                .where((record) => record.myDeckId == deck.deckId)
                .toList()
                .length;
        useDeckPercentageList.add(
          DeckPercentageData(
            percentage: percentage,
            winRate: winRate,
            deck: deck,
            wins: wins,
            loses: loses,
            count: deckCount,
          ),
        );
      }
    }
  }

  void makeOpponentDeckPercentageList() {
    for (final deck in deckList) {
      final percentage = recordList
              .where((record) => record.opponentDeckId == deck.deckId)
              .toList()
              .length /
          recordList.length;
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
      final deckCount = recordList
          .where((record) => record.opponentDeckId == deck.deckId)
          .toList()
          .length;
      opponentDeckPercentageList.add(
        DeckPercentageData(
          percentage: percentage,
          deck: deck,
          wins: wins,
          loses: loses,
          count: deckCount,
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

/// 使用デッキ割合用のデータクラス
class DeckPercentageData {
  DeckPercentageData(
      {this.percentage,
      this.deck,
      this.winRate,
      this.color,
      this.wins,
      this.loses,
      this.count});

  double percentage;
  Deck deck;
  double winRate;
  Color color;
  int wins;
  int loses;
  int count;
}
