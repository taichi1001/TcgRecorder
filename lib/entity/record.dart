import 'package:flutter/material.dart';

class Record with ChangeNotifier {
  int recordId;
  DateTime date;
  int gameId;
  int tagId;
  int myDeckId;
  int opponentDeckId;
  bool firstOrSecond;
  bool winOrLose;
  String memo;

  String game;
  String tag;
  String myDeck;
  String opponentDeck;

  Record(
      {this.recordId,
      this.date,
      this.gameId,
      this.tagId,
      this.myDeckId,
      this.opponentDeckId,
      this.firstOrSecond,
      this.winOrLose,
      this.memo});

  factory Record.fromDatabaseJson(Map<String, dynamic> data) => Record(
        recordId: data['record_id'],
        date: DateTime.parse(data['date']).toLocal(),
        gameId: data['game_id'],
        tagId: data['tag_id'],
        myDeckId: data['my_deck_id'],
        opponentDeckId: data['opponent_deck_id'],
        firstOrSecond: data['first_or_second'] == 1 ? true : false,
        winOrLose: data['win_or_lose'] == 1 ? true : false,
        memo: data['memo'],
      );

  Map<String, dynamic> toDatabaseJson() => {
        'record_id': recordId,
        'date': date.toUtc().toIso8601String(),
        'game_id': gameId,
        'tag_id': tagId,
        'my_deck_id': myDeckId,
        'opponent_deck_id': opponentDeckId,
        'first_or_second': firstOrSecond ? 1 : 0,
        'win_or_lose': winOrLose ? 1 : 0,
        'memo': memo,
      };
}
