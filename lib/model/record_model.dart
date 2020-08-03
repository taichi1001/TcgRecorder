import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  Game game;
  Tag selectTag;
  List<Record> allRecordList;
  List<Record> gameRecordList;
  List<Record> tagRecordList;

  final recordRepo = RecordRepo();

  RecordModel(this.game) {
    _fetchAll();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAll();
    gameRecordList = await recordRepo.getGameRecord(game.gameId);
    gameRecordList = await recordRepo.getTagRecord(selectTag.tagId);
    notifyListeners();
  }

  Future add(Record record) async {
    recordRepo.insert(record);
    _fetchAll();
  }

  Future update(Record record) async {
    await recordRepo.update(record);
    _fetchAll();
  }

  Future remove(Record record) async {
    await recordRepo.deleteById(record.recordId);
    _fetchAll();
  }
}
