import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  List<Tag> allTagList;

  final recordRepo = RecordRepo();

  RecordModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    allTagList = await recordRepo.getAllTag();
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
