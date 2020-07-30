import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/tag_model.dart';
import 'package:tcg_recorder/repository/mapping_name_record_repository.dart';
import 'package:tcg_recorder/repository/rank_rate_repository.dart';
import 'package:tcg_recorder/repository/record_contents_repository.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class RecordModel with ChangeNotifier {
  int selectedTagId = 0;
  String selectedTag;
  List<Record> allRecordList = [];
  List<Record> toDisplayRecord = [];

  final RecordRepo recordRepo = RecordRepo();
  final RecordContentsRepo recordContentsRepo = RecordContentsRepo();
  final MappingNameRecordRepo mappingRepo = MappingNameRecordRepo();
  final RankRateRepo rankRateRepo = RankRateRepo();

  RecordModel() {
    _fetchAll();
  }

  /// 選択されたタグに応じて保持するタグデータを変更する
  void changeSelectedTag(String newTag, TagModel tagModel) {
    if(newTag == 'all') {
      selectedTagId = 0;
      selectedTag = 'all';
      }
    for (final tag in tagModel.allTagList) {
      if (tag.tag == newTag) {
        selectedTagId = tag.tagId;
        selectedTag = tag.tag;
      }
    }
    _fetchAll();
  }

  /// 選択されたタグによって表示するレコードを切り替える
  void _selectToRecordDisplay() {
    if (selectedTagId == 0) {
      selectedTag = 'all';
      toDisplayRecord = allRecordList;
    } else {
      toDisplayRecord = allRecordList
          .where((record) => record.tagId == selectedTagId)
          .toList();
    }
    notifyListeners();
  }
  void notify(){
    notifyListeners();
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAllRecords();
    _selectToRecordDisplay();
    notifyListeners();
  }

  Future add(Record record) async {
    await recordRepo.insertRecord(record);
    _fetchAll();
  }

  Future update(Record record) async {
    await recordRepo.updateRecord(record);
    _fetchAll();
  }

  Future toggleIsDone(Record record) async {
    record.isEdit = !record.isEdit;
    update(record);
  }

  Future remove(Record record) async {
    await recordRepo.deleteRecordById(record.recordId);
    _fetchAll();
  }

  Future removeRelatedData(Record record) async {
    await recordRepo.deleteRecordById(record.recordId);
    await recordContentsRepo.deleteRecordContentsByRecordId(record.recordId);
    await rankRateRepo.deleteRankRateByRecordId(record.recordId);
    await mappingRepo.deleteMappingByRecordId(record.recordId);
    _fetchAll();
  }
}
