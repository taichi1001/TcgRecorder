import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/deck.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/repository/deck_repository.dart';

class GraphModel with ChangeNotifier {
  final Game selectedGame;
  List<Record> recordList;
  List<Deck> deckList;
  List<WinRateData> winRateList = [];
  List<DeckPercentageData> useDeckPercentageList = [];
  List<DeckPercentageData> opponentDeckPercentageList = [];

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
      final percentage =
          recordList.where((record) => record.myDeckId == deck.deckId).toList().length /
              recordList.length;
      useDeckPercentageList.add(DeckPercentageData(percentage: percentage, deck: deck));
    }
  }

  void makeOpponentDeckPercentageList() {
    for (final deck in deckList) {
      final percentage =
          recordList.where((record) => record.opponentDeckId == deck.deckId).toList().length /
              recordList.length;
      opponentDeckPercentageList.add(DeckPercentageData(percentage: percentage, deck: deck));
    }
  }
}

/// 勝率グラフ用のデータクラス
class WinRateData {
  WinRateData({this.winRate, this.record});
  double winRate;
  Record record;
}

/// 使用デッキ割合グラフ用のデータクラス
class DeckPercentageData {
  DeckPercentageData({this.percentage, this.deck, this.color});
  double percentage;
  Deck deck;
  Color color;
}
