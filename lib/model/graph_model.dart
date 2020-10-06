import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class GraphModel with ChangeNotifier {
  final Game selectedGame;
  Deck selectedDeck;
  List<Record> recordList;
  List<Deck> deckList;
  UseDeckDetailDataGridSource useDeckDetailDataGridSource;
  VsDeckDetailDataGridSource vsDeckDetailDataGridSource;
  List<WinRateData> winRateList = [];
  List<DeckDetailData> useDeckDetailList = [];
  List<DeckDetailData> opponentDeckDetailList = [];
  List<DeckDetailData> vsDeckDetailList = [];

  final RecordRepo recordRepo;
  final DeckRepo deckRepo;

  GraphModel({
    @required this.selectedGame,
    @required this.recordRepo,
    @required this.deckRepo,
  }) {
    fetchAll();
  }

  Future fetchAll() async {
    recordList = await recordRepo.getGameRecord(selectedGame.gameId);
    deckList = await deckRepo.getGameDeck(selectedGame.gameId);
    makeWinRateList();
    makeUseDeckPercentageList();
    makeAllUseDeckPercentageList();
    makeOpponentDeckPercentageList();
    notifyListeners();

    return 1;
  }

  void makeWinRateList() {
    final tmpRecordList = [];
    var count = 0;
    for (final record in recordList) {
      count++;
      tmpRecordList.add(record);
      final matches = tmpRecordList.length;
      final wins = tmpRecordList.where((record) => record.winOrLose == 1).length;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
      winRateList.add(
        WinRateData(
          count: count,
          winRate: winRate,
          record: record,
        ),
      );
    }
  }

  void makeAllUseDeckPercentageList() {
    final matches = recordList.length;
    final wins = recordList.where((record) => record.winOrLose == 1).toList().length;
    final loses = matches - wins;
    final winRate = ((wins / matches * 100) * 10).round() / 10;
    useDeckDetailList.add(
      DeckDetailData(
        deck: Deck(deck: '合計'),
        matches: matches,
        wins: wins,
        loses: loses,
        useageRate: 100,
        winRate: winRate,
      ),
    );
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
      final loses = matches - wins;
      final useageRate = ((matches / recordList.length * 100) * 10).round() / 10;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
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
      final loses = matches - wins;
      final useageRate = ((matches / recordList.length * 100) * 10).round() / 10;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
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

  void make2() {
    useDeckDetailDataGridSource = UseDeckDetailDataGridSource(useDeckDetailList);
  }

  void make() {
    vsDeckDetailList = [];
    final vsDeck = recordList.where((record) => record.myDeckId == selectedDeck.deckId).toList();
    for (final opponentDeck in deckList) {
      final matches =
          vsDeck.where((record) => record.opponentDeckId == opponentDeck.deckId).toList().length;
      if (matches == 0) continue;
      final wins = vsDeck
          .where((record) => record.opponentDeckId == opponentDeck.deckId)
          .toList()
          .where((record) => record.winOrLose == 1)
          .toList()
          .length;
      final loses = vsDeck
          .where((record) => record.opponentDeckId == opponentDeck.deckId)
          .toList()
          .where((record) => record.winOrLose == 2)
          .toList()
          .length;
      final useageRate = ((matches / vsDeck.length * 100) * 10).round() / 10;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
      vsDeckDetailList.add(
        DeckDetailData(
          deck: opponentDeck,
          matches: matches,
          wins: wins,
          loses: loses,
          useageRate: useageRate,
          winRate: winRate,
        ),
      );
      vsDeckDetailDataGridSource = VsDeckDetailDataGridSource(vsDeckDetailList);
    }
  }
}

class UseDeckDetailDataGridSource extends DataGridSource {
  UseDeckDetailDataGridSource(List<DeckDetailData> list) {
    useDeckDetailList = list;
  }

  List<DeckDetailData> _useDeckDetailList = [];
  set useDeckDetailList(List<DeckDetailData> newList) {
    _useDeckDetailList = newList;
  }

  @override
  List<Object> get dataSource => _useDeckDetailList;

  @override
  Object getCellValue(int rowIndex, String columnName) {
    switch (columnName) {
      case 'deck':
        return _useDeckDetailList[rowIndex].deck.deck;
        break;
      case 'matches':
        return _useDeckDetailList[rowIndex].matches;
        break;
      case 'win':
        return _useDeckDetailList[rowIndex].wins;
        break;
      case 'lose':
        return _useDeckDetailList[rowIndex].loses;
        break;
      case 'winRate':
        return _useDeckDetailList[rowIndex].winRate;
        break;
      default:
        return ' ';
        break;
    }
  }
}

class VsDeckDetailDataGridSource extends DataGridSource {
  VsDeckDetailDataGridSource(List<DeckDetailData> list) {
    vsDeckDetailList = list;
  }

  List<DeckDetailData> _vsDeckDetailList = [];
  set vsDeckDetailList(List<DeckDetailData> newList) {
    _vsDeckDetailList = newList;
  }

  @override
  List<Object> get dataSource => _vsDeckDetailList;

  @override
  Object getCellValue(int rowIndex, String columnName) {
    switch (columnName) {
      case 'deck':
        return _vsDeckDetailList[rowIndex].deck.deck;
        break;
      case 'matches':
        return _vsDeckDetailList[rowIndex].matches;
        break;
      case 'win':
        return _vsDeckDetailList[rowIndex].wins;
        break;
      case 'lose':
        return _vsDeckDetailList[rowIndex].loses;
        break;
      case 'winRate':
        return _vsDeckDetailList[rowIndex].winRate;
        break;
      default:
        return ' ';
        break;
    }
  }
}

/// 勝率推移グラフ用のデータクラス
class WinRateData {
  WinRateData({this.count, this.winRate, this.record});
  int count;
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
