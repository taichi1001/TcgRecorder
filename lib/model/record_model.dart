import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  List<Record> allRecordList;

  final recordRepo = RecordRepo();

  RecordModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAllTag();
    notifyListeners();
  }

  Future add(Record record) async {
    recordRepo.insertTag(record);
    _fetchAll();
  }

  Future update(Record record) async {
    await recordRepo.updateTag(record);
    _fetchAll();
  }

  Future remove(Record record) async {
    await recordRepo.deleteTagById(record.recordId);
    _fetchAll();
  }
}
