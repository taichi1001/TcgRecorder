import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/name.dart';
import 'package:tcg_recorder/entity/mapping_name_record.dart';
import 'package:tcg_recorder/entity/record_contents.dart';
import 'package:tcg_recorder/repository/mapping_name_record_repository.dart';
import 'package:tcg_recorder/repository/name_repository.dart';
import 'package:tcg_recorder/repository/record_contents_repository.dart';
import 'package:tcg_recorder/repository/record_repository.dart';

class ManageDBModel with ChangeNotifier {
  List<Record> allRecordList = [];
  List<RecordContents> allRecordContentsList = [];
  List<Name> allNameList = [];
  List<MappingNameRecord> allCorrespondenceList = [];

  final nameRepo = NameRepo();
  final correspondenceRepo = MappingNameRecordRepo();
  final recordRepo = RecordRepo();
  final recordContentsRepo = RecordContentsRepo();

  ManageDBModel() {
    fetchAll();
  }

  Future fetchAll() async {
    allRecordList = await recordRepo.getAllRecords();
    allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    allNameList = await nameRepo.getAllName();
    allCorrespondenceList = await correspondenceRepo.getAllMapping();
    notifyListeners();
  }
}
