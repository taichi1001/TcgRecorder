import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:quiver/iterables.dart';
import 'package:tcg_recorder/entity/mapping_name_record.dart';
import 'package:tcg_recorder/entity/name.dart';
import 'package:tcg_recorder/entity/record_contents.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/entity/tag.dart';
import 'package:tcg_recorder/repository/mapping_name_record_repository.dart';
import 'package:tcg_recorder/repository/name_repository.dart';
import 'package:tcg_recorder/repository/rank_rate_repository.dart';
import 'package:tcg_recorder/repository/record_contents_repository.dart';
import 'package:tcg_recorder/repository/record_repository.dart';
import 'package:tcg_recorder/repository/tag_repository.dart';

class GraphModel with ChangeNotifier {
  String selectTagName;
  List<Record> allRecordList;
  List<Record> tagRecordList;
  List<Tag> allTagList;
  List<Name> allNameList;
  List<Name> tagNameList;
  List<MappingNameRecord> allMappingList;
  List<MappingNameRecord> tagMappingList;
  List<RecordContents> allRecordContentsList;
  List<RecordContents> tagRecordContentsList;
  Map<String, List<int>> scoreMap = {};
  Map<String, List<int>> xAxis = {};
  Map<String, int> nameCheckMap = {};
  int _scoreMapLengthMax;

  final RecordRepo recordRepo = RecordRepo();
  final MappingNameRecordRepo mappingRepo = MappingNameRecordRepo();
  final TagRepo tagRepo = TagRepo();
  final NameRepo nameRepo = NameRepo();
  final RecordContentsRepo recordContentsRepo = RecordContentsRepo();
  final RankRateRepo rankRateRepo = RankRateRepo();

  GraphModel(this.selectTagName) {
    _fetchAll();
  }

  /// 指定されたタグに該当するレコードのリストを取得する
  void _getTagRecordList() {
    final tag = allTagList.where((tag) => tag.tag == selectTagName).toList()[0];
    tagRecordList =
        allRecordList.where((record) => record.tagId == tag.tagId).toList();
  }

  /// tagRecordListを日付順(昇順)にソートする
  void _sortTagRecordList() {
    tagRecordList.sort((k1, k2) => k1.date.compareTo(k2.date));
  }

  /// 指定されたタグに該当するMappingのリストを取得する
  void _getTagMappingList() {
    final List<MappingNameRecord> list = [];
    for (final mapping in allMappingList) {
      for (final record in tagRecordList) {
        if (mapping.recordId == record.recordId) {
          list.add(mapping);
        }
      }
    }
    tagMappingList = list;
  }

  /// 指定されたタグに該当する名前のリストを取得する
  void _getTagNameList() {
    final List<Name> list = [];
    for (final mapping in tagMappingList) {
      for (final name in allNameList) {
        if (mapping.nameId == name.nameId) {
          if (list
              .where((element) => element.name == name.name)
              .toList()
              .isEmpty) {
            list.add(name);
          }
        }
      }
    }
    list.toSet().toList();
    tagNameList = list;
  }

  /// 指定されたタグに該当するRecordContentsのリストを取得する
  void _getTagRecordContentsList() {
    final List<RecordContents> list = [];
    for (final record in tagRecordList) {
      for (final recordContents in allRecordContentsList) {
        if (record.recordId == recordContents.recordId) {
          list.add(recordContents);
        }
      }
    }
    tagRecordContentsList = list;
  }

  /// tagRecordContentsListをRecordごとに試合順(昇順)にソートする
  void _sortTagRecordContentsList() {
    final List<List<RecordContents>> sortedTagRecordContentsLists = [];
    for (final record in tagRecordList) {
      final List<RecordContents> sortedTagRecordContentsList = [];
      for (final recordContents in tagRecordContentsList) {
        if (record.recordId == recordContents.recordId) {
          sortedTagRecordContentsList.add(recordContents);
        }
      }
      sortedTagRecordContentsLists.add(sortedTagRecordContentsList);
    }
    for (final sortedTagRecordContentsList in sortedTagRecordContentsLists) {
      sortedTagRecordContentsList
          .sort((k1, k2) => k1.count.compareTo(k2.count));
    }
    tagRecordContentsList =
        sortedTagRecordContentsLists.expand((pair) => pair).toList();
  }

  /// スコア用Mapを初期化
  void _initScoreMap() {
    for (final name in tagNameList) {
      final initList = [0];
      scoreMap[name.name] = initList;
    }
  }

  /// 名前があるかどうかの判定用Mapを初期化
  void _initNameCheckMap() {
    for (final name in tagNameList) {
      nameCheckMap[name.name] = 0;
    }
  }

  /// 指定されたタグに該当するスコアを名前ごとにMapで取得
  ///
  /// ex. {a:[0,1,2,4], b:[0,2,4,6]}
  void _getTagScore() {
    for (final contents in tagRecordContentsList) {
      _processingPersonNotInPreviousGame(contents);
      _putScoreOfNameWhoMatchContentInArray(contents);
    }
    scoreMap.forEach((key, value) {
      if (value.length < _scoreMapLengthMax) {
        scoreMap[key].add(scoreMap[key].last);
      }
    });
  }

  /// 入力されたcontentsとマッチする名前のスコアを配列に加える
  void _putScoreOfNameWhoMatchContentInArray(RecordContents contents) {
    for (final name in tagNameList) {
      if (name.nameId == contents.nameId) {
        scoreMap[name.name].add(scoreMap[name.name].last + contents.calcScore);
        nameCheckMap[name.name]++;
      }
    }
  }

  /// 1つ前のゲームに参加していなかった人の処理
  void _processingPersonNotInPreviousGame(RecordContents contents) {
    final List<int> scoreMapLengthList = [];
    scoreMap.forEach((key, value) {
      final scoreMapLength = value.length;
      scoreMapLengthList.add(scoreMapLength);
    });
    _scoreMapLengthMax = scoreMapLengthList.reduce(math.max);
    //最初のレコードの最初の試合以外ならtrue（つまり一番最初）
    if (nameCheckMap.values.toList()[0] != 0) {
      nameCheckMap.forEach((key, value) {

        if (value < _scoreMapLengthMax - 2) {
          print(key);
          print(value);
          print(_scoreMapLengthMax);
          scoreMap[key].add(scoreMap[key].last);
          nameCheckMap[key]++;
        }
      });
    }
  }

  /// x軸となるMapを取得
  void _getXAxis() {
    final rangeXAxis = range(1, int.parse(scoreMap.keys.toList()[0]));
    for (final key in scoreMap.keys.toList()) {
      xAxis[key] = rangeXAxis;
    }
  }

  Future _fetchAll() async {
    allRecordList = await recordRepo.getAllRecords();
    allTagList = await tagRepo.getAllTag();
    allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    allNameList = await nameRepo.getAllName();
    allMappingList = await mappingRepo.getAllMapping();

    _getTagRecordList();
    _sortTagRecordList();
    _getTagMappingList();
    _getTagNameList();
    _getTagRecordContentsList();
    _sortTagRecordContentsList();
    _initScoreMap();
    _initNameCheckMap();
    _getTagScore();
//    _getXAxis();
  }
}
