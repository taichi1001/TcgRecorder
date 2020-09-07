import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  Game game;
  Tag selectedTag;
  int firstOrSecond = 1;
  int winOrLose = 1;
  List<Record> allRecordList;
  List<Record> gameRecordList;
  List<Record> tagRecordList;

  final recordRepo = RecordRepo();

  RecordModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAll();
    // gameRecordList = await recordRepo.getGameRecord(game.gameId);
    // tagRecordList = await recordRepo.getTagRecord(selectedTag.tagId);
    notifyListeners();
  }

  void changeFirstOrSecond() {
    firstOrSecond = firstOrSecond == 1 ? 2 : 1;
    notifyListeners();
  }

  void changeWinOrLose() {
    winOrLose = winOrLose == 1 ? 2 : 1;
    notifyListeners();
  }

  Future add(Record record) async {
    await recordRepo.insert(record);
    await _fetchAll();
  }

  Future update(Record record) async {
    await recordRepo.update(record);
    await _fetchAll();
  }

  Future remove(Record record) async {
    await recordRepo.deleteById(record.recordId);
    await _fetchAll();
  }
}
