import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class GraphModel with ChangeNotifier {
  final Game selectedGame;
  List<Record> recordList;
  List<WinRateData> winRateList = [];

  final recordRepo = RecordRepo();

  GraphModel({@required this.selectedGame}) {
    _fetchAll();
  }

  Future _fetchAll() async {
    recordList = await recordRepo.getGameRecord(selectedGame.gameId);
    makeWinRateList();
    notifyListeners();
  }

  void makeWinRateList() {
    final List<Record> tmpRecordList = [];
    for (final record in recordList) {
      tmpRecordList.add(record);
      final matches = tmpRecordList.length;
      final wins = tmpRecordList.where((record) => record.winOrLose == 1).length;
      final winRate = ((wins / matches * 100) * 10).round() / 10;
      winRateList.add(WinRateData(winRate, record));
    }
  }
}

/// グラフ用のデータクラス
class WinRateData {
  WinRateData(this.winRate, this.record);
  double winRate;
  Record record;
}
