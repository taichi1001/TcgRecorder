import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/rank_rate.dart';
import 'package:tcg_recorder/entity/record_contents.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/model/name_model.dart';
import 'package:tcg_recorder/repository/rank_rate_repository.dart';
import 'package:tcg_recorder/repository/record_contents_repository.dart';

class RecordContentsModel with ChangeNotifier {
  final Record record;
  NameModel nameModel;
  List<RecordContents> allRecordContentsList = [];
  List<RecordContents> recordContentsList = [];
  List<List<RecordContents>> recordContentsPerCount = [];
  List<RankRate> recordRankRateList = [];
  Map<String, int> scoreMap = {};
  int count = 0;

  final RecordContentsRepo recordContentsRepo = RecordContentsRepo();
  final RankRateRepo rankRateRepo = RankRateRepo();

  RecordContentsModel({this.record}) {
    nameModel = NameModel(record: record);
    fetchAll();
  }

  /// 入力されたRecordContentsを登録する
  Future addNewRecordContents(List<TextEditingController> textList) async {
    count++;
    var index = 0;
    for (final text in textList) {
      await recordContentsRepo.insertRecordContents(
        RecordContents(
          recordId: record.recordId,
          nameId: nameModel.recordNameList[index].nameId,
          count: count,
          score: int.parse(text.text),
        ),
      );
      index++;
    }
    await fetchAll();
  }

  /// ランクレートを更新する
  Future updateRankRate(List<TextEditingController> textList) async {
    var index = 0;
    for (final text in textList) {
      if (recordRankRateList[index].rate != int.parse(text.text)) {
        recordRankRateList[index].rate = int.parse(text.text);
        rankRateRepo.updateRankRate(recordRankRateList[index]);
      }
      index++;
    }
    await fetchAll();
  }

  /// レコードに対応するランクレートを初期化する
  Future initRankRate() async {
    if (recordRankRateList.isEmpty) {
      for (int rank = 1; rank <= nameModel.recordNameList.length; rank++) {
        await rankRateRepo.insertRankRate(
          RankRate(
            recordId: record.recordId,
            rank: rank,
          ),
        );
      }
    }
  }

  // スコア計算
  void calcScore() {
    _initScore();
    if (record.mode == '順位モード') {
      if (!record.isDuplicate) {
        _calcByRankMode();
      } else {
        _calculateByRankDuplicateMode();
      }
    } else {
      _calcByScoreMode();
    }
  }

  /// スコアを初期化する
  void _initScore() {
    for (final name in nameModel.recordNameList) {
      scoreMap[name.name] = 0;
    }
  }

  /// スコアモード時のスコア計算
  void _calcByScoreMode() {
    for (final name in nameModel.recordNameList) {
      for (final contents in recordContentsList) {
        if (name.nameId == contents.nameId) {
          updateCalcScore(contents);
          scoreMap[name.name] = scoreMap[name.name] + contents.score;
        }
      }
    }
  }

  /// 順位モード時のスコア計算
  void _calcByRankMode() {
    for (final name in nameModel.recordNameList) {
      for (final contents in recordContentsList) {
        if (name.nameId == contents.nameId) {
          for (final rankRate in recordRankRateList) {
            if (contents.score == rankRate.rank) {
              updateCalcScore(contents, rankRate.rate);
              scoreMap[name.name] = scoreMap[name.name] + rankRate.rate;
              break;
            }
          }
        }
      }
    }
  }

  /// 順位重複モード時のスコア計算
  void _calculateByRankDuplicateMode() {
    _initScore();
    for (final perCount in recordContentsPerCount) {
      final List<List<RecordContents>> interimDupLists =
          _makeDuplists(perCount);
      final List<List<RecordContents>> dupLists =
          _removeDuplicateFromDuplists(interimDupLists);
      final List<RecordContents> flatDupList =
          dupLists.expand((pair) => pair).toList();
      final List<RecordContents> noDupList =
          perCount.where((element) => !flatDupList.contains(element)).toList();
      _calcContentsScoreNoDupList(noDupList);
      if (dupLists.isNotEmpty) {
        for (final dupList in dupLists) {
          final dupRate = _calcRateDuplicatedScore(dupList);
          _calcDuplicatedScore(dupList, dupRate);
        }
      }
    }
  }

  /// 重複しているRecordContentsのスコアを計算する
  void _calcDuplicatedScore(List<RecordContents> dupList, int dupRate) {
    for (final name in nameModel.recordNameList) {
      for (final contents in dupList) {
        if (name.nameId == contents.nameId) {
          updateCalcScore(contents, dupRate);
          scoreMap[name.name] = scoreMap[name.name] + dupRate;
        }
      }
    }
  }

  /// 重複しているRecordContentsに適用するレートを計算する
  int _calcRateDuplicatedScore(List<RecordContents> dupList) {
    var sumDupRate = 0;
    for (int i = 0; i < dupList.length; i++) {
      for (final rankRate in recordRankRateList) {
        if (dupList[0].score + i == rankRate.rank) {
          sumDupRate += rankRate.rate;
        }
      }
    }
    return (sumDupRate / dupList.length).round();
  }

  /// 重複していないRecordContentsを計算する
  void _calcContentsScoreNoDupList(List<RecordContents> noDupList) {
    for (final name in nameModel.recordNameList) {
      for (final contents in noDupList) {
        if (name.nameId == contents.nameId) {
          for (final rankRate in recordRankRateList) {
            if (contents.score == rankRate.rank) {
              updateCalcScore(contents, rankRate.rate);
              scoreMap[name.name] = scoreMap[name.name] + rankRate.rate;
              break;
            }
          }
        }
      }
    }
  }

  /// _makeDuplistsで生じる同じ組み合わせのうちの1つを削除する
  List<List<RecordContents>> _removeDuplicateFromDuplists(
      List<List<RecordContents>> dupLists) {
    var rank = 0;
    final List<List<RecordContents>> dupListsB = [];
    for (final dupList in dupLists) {
      if (rank != dupList[0].score) {
        dupListsB.add(dupList);
        rank = dupList[0].score;
      }
    }
    return dupListsB;
  }

  /// 入力されたRecordContentsのリストから重複している要素を抽出する
  ///
  /// 重複している要素が2回づつ抽出されるのは仕様のため注意
  ///
  /// _removeDuplicateFromDuplistsと組み合わせて使う
  List<List<RecordContents>> _makeDuplists(List<RecordContents> perCount) {
    final List<List<RecordContents>> dupLists = [];
    for (final recordContents1 in perCount) {
      int dupCount = 0;
      final List<RecordContents> dupList = [];
      for (final recordContents2 in perCount) {
        if (recordContents1.score == recordContents2.score) {
          dupCount++;
          if (dupCount == 2) {
            dupList.add(recordContents1);
            dupList.add(recordContents2);
            dupLists.add(dupList);
          } else if (dupCount > 2) {
            dupList.add(recordContents2);
            dupLists.add(dupList);
          }
        }
      }
    }
    return dupLists;
  }

  void _sortScore() {
    final sortedKeys = scoreMap.keys.toList(growable: false)
      ..sort((k1, k2) => scoreMap[k2].compareTo(scoreMap[k1]));
    final LinkedHashMap<String, int> sortedMap = LinkedHashMap.fromIterable(
        sortedKeys,
        key: (k) => k,
        value: (k) => scoreMap[k]);
    scoreMap = sortedMap;
  }

  void _getRecordContentsPerCount() {
    final List<List<RecordContents>> __recordContentsPerCount = [];

    for (int count = 1; count <= this.count; count++) {
      final List<RecordContents> perCount = [];
      for (final recordContents in recordContentsList) {
        if (recordContents.count == count) {
          perCount.add(recordContents);
        }
      }
      __recordContentsPerCount.add(perCount);
    }
    recordContentsPerCount = __recordContentsPerCount;
  }

  void _getRecordContentsList() {
    recordContentsList = allRecordContentsList
        .where((recordContents) => recordContents.recordId == record.recordId)
        .toList();
  }

  void _getCount() {
    int count = 0;
    if (recordContentsList.isNotEmpty) {
      count = recordContentsList
          .map((recordContents) => recordContents.count)
          .toList()
          .reduce(max);
    }
    this.count = count;
  }

  Future updateCalcScore(RecordContents contents, [int rate]) async {
    if (rate == null && contents.calcScore != contents.score) {
      contents.calcScore = contents.score;
    } else if (contents.calcScore != rate) {
      contents.calcScore = rate;
    } else {
      return;
    }
    await recordContentsRepo.updateRecordContents(contents);
  }

  Future fetchAll() async {
    allRecordContentsList = await recordContentsRepo.getAllRecordsContents();
    recordRankRateList = await rankRateRepo.getRankRateByID(record.recordId);
    _getRecordContentsList();
    _getCount();
    _getRecordContentsPerCount();
    calcScore();
    _sortScore();
    notifyListeners();
  }

  Future add(RecordContents recordContents) async {
    await recordContentsRepo.insertRecordContents(recordContents);
    fetchAll();
  }

  Future update(RecordContents recordContents) async {
    await recordContentsRepo.updateRecordContents(recordContents);
    fetchAll();
  }

  Future remove(RecordContents recordContents) async {
    await recordContentsRepo
        .deleteRecordContentsById(recordContents.recordContentsId);
    fetchAll();
  }
}
