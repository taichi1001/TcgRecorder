import 'package:flutter/material.dart';

class Record2 with ChangeNotifier {
  int recordId;
  DateTime date;
  int gameId;
  int tagId;
  int myDeckId;
  int opponentDeckId;
  int firstOrSecond;
  int winOrLose;
  String memo;

  Record2(
      {this.recordId,
      this.date,
      this.gameId,
      this.tagId,
      this.myDeckId,
      this.opponentDeckId,
      this.firstOrSecond,
      this.winOrLose,
      this.memo});

  factory Record2.fromDatabaseJson(Map<String, dynamic> data) => Record2(
        recordId: data['record_id'],
        date: DateTime.parse(data['date']).toLocal(),
        gameId: data['game_id'],
        tagId: data['tag_id'],
        myDeckId: data['my_deck_id'],
        opponentDeckId: data['opponent_deck_id'],
        firstOrSecond: data['first_or_seconde'],
        winOrLose: data['win_or_lose'],
        memo: data['memo'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'record__id': recordId,
        'date': date.toUtc().toIso8601String(),
        'game_id': gameId,
        'tag_id': tagId,
        'my_deck_id': myDeckId,
        'opponent_deck_id': opponentDeckId,
        'first_or_second': firstOrSecond,
        'win_or_lose': winOrLose,
        'memo': memo,
      };
}
