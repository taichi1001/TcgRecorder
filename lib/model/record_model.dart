import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  Game selectedGame;
  Tag selectedTag;
  bool firstOrSecond = true;
  bool winOrLose = true;
  List<Record> allRecordList = [];
  List<Record> gameRecordList(Game game) =>
      allRecordList.where((record) => record.gameId == game.gameId).toList();
  List<Record> tagRecordList(Tag tag) =>
      allRecordList.where((record) => record.tagId == tag.tagId).toList();
  List<Record> showRecordList;
  final RecordRepo recordRepo;

  RecordModel(this.recordRepo) {
    _fetchAll();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAll();
    sortDescendingOrderRecordList(allRecordList);
    notifyListeners();
  }

  List<Record> getGameRecordList(int id) {
    return allRecordList.where((record) => record.gameId == id).toList();
  }

  void makeShowRecordList(int id) {
    showRecordList = getGameRecordList(id);
    sortAscendingOrderRecordList(showRecordList);
  }

  void sortAscendingOrderRecordList(List<Record> list) {
    list.sort((a, b) => a.recordId.compareTo(b.recordId));
  }

  void sortDescendingOrderRecordList(List<Record> list) {
    list.sort((a, b) => b.recordId.compareTo(a.recordId));
  }

  void changeFirstOrSecond(int index) {
    firstOrSecond = index == 0 ? true : false;
    notifyListeners();
  }

  void changeWinOrLose(int index) {
    winOrLose = index == 0 ? true : false;
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
    allRecordList = await recordRepo.getAll();
    // await Future.delayed(Duration(milliseconds: 1000));
    // await _fetchAll();
  }
}
