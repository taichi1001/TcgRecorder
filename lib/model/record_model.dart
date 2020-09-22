import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  Game selectedGame;
  Tag selectedTag;
  int firstOrSecond = 1;
  int winOrLose = 1;
  List<Record> allRecordList = [];
  List<Record> gameRecordList(Game game) =>
      allRecordList.where((record) => record.gameId == game.gameId).toList();
  List<Record> tagRecordList(Tag tag) =>
      allRecordList.where((record) => record.tagId == tag.tagId).toList();
  final RecordRepo recordRepo;

  RecordModel(this.recordRepo) {
    _fetchAll();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAll();
    notifyListeners();
  }

  List<Record> getGameRecordList(Game game) {
    return allRecordList
        .where((record) => record.gameId == game.gameId)
        .toList();
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
