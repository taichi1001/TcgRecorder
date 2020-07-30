import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/name.dart';
import 'package:tcg_recorder/entity/mapping_name_record.dart';
import 'package:tcg_recorder/repository/mapping_name_record_repository.dart';
import 'package:tcg_recorder/repository/name_repository.dart';

class NameModel with ChangeNotifier {
  Record record;
  List<Name> allNameList;
  List<Name> recordNameList;
  bool isUpdate = true;
  List<MappingNameRecord> _allCorrespondenceList;
  List<MappingNameRecord> _recordCorrespondenceList;

  final nameRepo = NameRepo();
  final mappingRepo = MappingNameRecordRepo();

  NameModel({this.record}) {
    _fetchAll();
  }

  void getRecordCorrespondenceList() {
    _recordCorrespondenceList = _allCorrespondenceList
        .where((correspondence) => correspondence.recordId == record.recordId)
        .toList();
  }

  /// レコードに対応する名前一覧を取得する
  void getRecordNameList() {
    final List<Name> list = [];
    for (final correspondence in _recordCorrespondenceList) {
      for (final name in allNameList) {
        if (correspondence.nameId == name.nameId) {
          list.add(name);
        }
      }
    }
    recordNameList = list;
  }

  /// レコードに対応する名前を更新するときに使う
  ///
  /// 既に登録されている名前に変更しようとした場合にisUpdateをfalseにする
  Future updateRecordName(List<TextEditingController> newTextList,
      List<TextEditingController> oldTextList) async {
    var index = 0;
    isUpdate = true;
    for (final text in newTextList) {
      if (text.text != oldTextList[index].text) {
        if (allNameList.map((name) => name.name).toList().contains(text.text)) {
          isUpdate = false;
          index++;
          break;
        } else {
          for (final name in allNameList) {
            if (name.name == oldTextList[index].text) {
              name.name = text.text;
              await nameRepo.updateName(name);
              break;
            }
          }
        }
      }
      index++;
    }
    await _fetchAll();
  }

  Future _fetchAll() async {
    allNameList = await nameRepo.getAllName();
    _allCorrespondenceList = await mappingRepo.getAllMapping();
    getRecordCorrespondenceList();
    getRecordNameList();
    notifyListeners();
  }

  /// 名前と、レコードと名前の対応をそれぞれDBに記録
  Future setNewName(List<TextEditingController> textList) async {
    for (final text in textList) {
      if (allNameList.map((name) => name.name).toList().contains(text.text)) {
        _registeredName(text.text);
      } else if (text.text.isNotEmpty) {
        final nameId = await nameRepo.insertName(Name(name: text.text));
        await mappingRepo.insertMapping(
            MappingNameRecord(nameId: nameId, recordId: record.recordId));
      }
    }
    await _fetchAll();
  }

  /// 既に登録されている名前の場合の処理
  Future _registeredName(String inName) async {
    for (final name in allNameList) {
      if (inName == name.name) {
        final nameId = name.nameId;
        await mappingRepo.insertMapping(
            MappingNameRecord(nameId: nameId, recordId: record.recordId));
      }
    }
  }

  Future add(Name name) async {
    nameRepo.insertName(name);
    _fetchAll();
  }

  Future update(Name name) async {
    await nameRepo.updateName(name);
    _fetchAll();
  }

  Future remove(Name name) async {
    await nameRepo.deleteNameById(name.nameId);
    _fetchAll();
  }
}
