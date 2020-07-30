import 'package:flutter/material.dart';

class RecordContents with ChangeNotifier {
  int recordContentsId;
  int recordId;
  int nameId;
  int count;
  int score;
  int calcScore;

  RecordContents(
      {this.recordContentsId,
      this.recordId,
      this.nameId,
      this.count,
      this.score,
      this.calcScore});

  factory RecordContents.fromDatabaseJson(Map<String, dynamic> data) =>
      RecordContents(
        recordContentsId: data['record_contents_id'],
        recordId: data['record_id'],
        nameId: data['name_id'],
        count: data['count'],
        score: data['score'],
        calcScore: data['calc_score'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'record_contents_id': recordContentsId,
        'record_id': recordId,
        'name_id': nameId,
        'count': count,
        'score': score,
        'calc_score': calcScore,
      };

  void updateScore(String newScore) {
    score = int.parse(newScore);
    notifyListeners();
  }
}
