import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class GraphModel with ChangeNotifier {
  Deck selectedDeck;
  UseDeckDetailDataGridSource useDeckDetailDataGridSource;
  SelectDeckDetailDataGridSource selectDeckDetailDataGridSource;
  List<WinRateData> winRateList = [];
  List<WinRateData> deckWinRateList = [];
  List<DeckDetailData> useDeckDetailList = [];
  List<DeckDetailData> useDeckGraphDetailList = [];
  List<DeckDetailData> opponentDeckDetailList = [];
  List<DeckDetailData> selectDeckDetailList = [];

  final RecordRepo recordRepo;
  final DeckRepo deckRepo;
  final List<Deck> deckList;
  final List<Record> recordList;

  GraphModel({
    @required this.deckList,
    @required this.recordList,
    @required this.recordRepo,
    @required this.deckRepo,
  }) {
    fetchAll();
  }

  Future fetchAll() async {
    winRateList = [];
    makeWinRateList();

    useDeckDetailList = [];
    useDeckGraphDetailList = [];
    makeUseDeckDetailList();

    opponentDeckDetailList = [];
    makeOpponentDeckDetailList();

    notifyListeners();
  }

  void makeWinRateList() {
    final tmpRecordList = [];
    winRateList = [];
    var count = 0;
    for (final record in recordList) {
      count++;
      tmpRecordList.add(record);
      final matches = tmpRecordList.length;
      final wins = tmpRecordList.where((record) => record.winOrLose == true).length;
      final winRate = _calcPercentage(wins, matches);
      winRateList.add(
        WinRateData(
          count: count,
          winRate: winRate,
          record: record,
        ),
      );
    }
  }

  void makeSelectedDeckWinRateList() {
    final tmpRecordList = [];
    deckWinRateList = [];
    var count = 0;
    final deckRecordList =
        recordList.where((record) => record.myDeckId == selectedDeck.deckId).toList();
    for (final record in deckRecordList) {
      count++;
      tmpRecordList.add(record);
      final matches = tmpRecordList.length;
      final wins = tmpRecordList.where((record) => record.winOrLose == true).length;
      final winRate = _calcPercentage(wins, matches);
      deckWinRateList.add(
        WinRateData(
          count: count,
          winRate: winRate,
          record: record,
        ),
      );
    }
  }

  void _makeAllUseDeckDetailList() {
    final matches = recordList.length;
    final wins = recordList.where((record) => record.winOrLose == true).toList().length;
    final loses = matches - wins;
    final winRate = _calcPercentage(wins, matches);
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

  void makeUseDeckDetailList() {
    if (recordList.isEmpty) return;
    for (final deck in deckList) {
      final matches = recordList.where((record) => record.myDeckId == deck.deckId).toList().length;
      if (matches == 0) continue;
      final wins = recordList
          .where((record) => record.myDeckId == deck.deckId)
          .toList()
          .where((record) => record.winOrLose == true)
          .toList()
          .length;
      final loses = matches - wins;
      final useageRate = _calcPercentage(matches, recordList.length);
      final winRate = _calcPercentage(wins, matches);
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
    useDeckGraphDetailList = useDeckDetailList.toList();
    sortDeckGraphDetailList(useDeckGraphDetailList);
    _makeAllUseDeckDetailList();
  }

  void sortDeckGraphDetailList(List<DeckDetailData> list) {
    list.sort((a, b) => b.matches.compareTo(a.matches));
  }

  void makeOpponentDeckDetailList() {
    for (final deck in deckList) {
      final matches =
          recordList.where((record) => record.opponentDeckId == deck.deckId).toList().length;
      if (matches == 0) continue;
      final wins = recordList
          .where((record) => record.opponentDeckId == deck.deckId)
          .toList()
          .where((record) => record.winOrLose == true)
          .toList()
          .length;
      final loses = matches - wins;
      final useageRate = _calcPercentage(matches, recordList.length);
      final winRate = _calcPercentage(wins, matches);
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
    sortDeckGraphDetailList(opponentDeckDetailList);
  }

  void make2() {
    useDeckDetailDataGridSource = UseDeckDetailDataGridSource(useDeckDetailList);
  }

  void makeSelectDeckDetailList() {
    selectDeckDetailList = [];
    final selectDeckList =
        recordList.where((record) => record.myDeckId == selectedDeck.deckId).toList();
    for (final opponentDeck in deckList) {
      final matches = selectDeckList
          .where((record) => record.opponentDeckId == opponentDeck.deckId)
          .toList()
          .length;
      if (matches == 0) continue;
      final wins = selectDeckList
          .where((record) => record.opponentDeckId == opponentDeck.deckId)
          .toList()
          .where((record) => record.winOrLose == true)
          .toList()
          .length;
      final loses = matches - wins;
      final useageRate = _calcPercentage(matches, selectDeckList.length);
      final winRate = _calcPercentage(wins, matches);
      selectDeckDetailList.add(
        DeckDetailData(
          deck: opponentDeck,
          matches: matches,
          wins: wins,
          loses: loses,
          useageRate: useageRate,
          winRate: winRate,
        ),
      );
    }
    _makeAllSelectDeckDetailList(selectDeckList);
    selectDeckDetailDataGridSource = SelectDeckDetailDataGridSource(selectDeckDetailList);
  }

  void _makeAllSelectDeckDetailList(List<Record> list) {
    final matches = list.length;
    final wins = list.where((record) => record.winOrLose == true).toList().length;
    final loses = matches - wins;
    final winRate = _calcPercentage(wins, matches);
    selectDeckDetailList.add(
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

  /// decimalPlaceには1または10の倍数を指定してください
  ///
  /// (例) 小数点第一位を四捨五入 : 10, 小数点第二位を四捨五入 : 100
  double _calcPercentage(int molecule, int denominator, {int decimalPlace = 10}) =>
      ((molecule / denominator * 100) * decimalPlace).round() / decimalPlace;
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

class SelectDeckDetailDataGridSource extends DataGridSource {
  SelectDeckDetailDataGridSource(List<DeckDetailData> list) {
    selectDeckDetailList = list;
  }

  List<DeckDetailData> _selectDeckDetailList = [];
  set selectDeckDetailList(List<DeckDetailData> newList) {
    _selectDeckDetailList = newList;
  }

  @override
  List<Object> get dataSource => _selectDeckDetailList;

  @override
  Object getCellValue(int rowIndex, String columnName) {
    switch (columnName) {
      case 'deck':
        return _selectDeckDetailList[rowIndex].deck.deck;
        break;
      case 'matches':
        return _selectDeckDetailList[rowIndex].matches;
        break;
      case 'win':
        return _selectDeckDetailList[rowIndex].wins;
        break;
      case 'lose':
        return _selectDeckDetailList[rowIndex].loses;
        break;
      case 'winRate':
        return _selectDeckDetailList[rowIndex].winRate;
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
