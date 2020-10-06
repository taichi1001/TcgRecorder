import 'package:flutter/material.dart';

class Game with ChangeNotifier {
  int gameId;
  String game;
  bool isVisibleToPicker;

  Game({
    this.gameId = 0,
    this.game,
    this.isVisibleToPicker = true,
  });

  factory Game.fromDatabaseJson(Map<String, dynamic> data) => Game(
        gameId: data['game_id'],
        game: data['game'],
        isVisibleToPicker: data['is_visible_to_picker'] == 1 ? true : false,
      );

  Map<String, dynamic> toDatabaseJson() => {
        'game_id': gameId,
        'game': game,
        'is_visible_to_picker': isVisibleToPicker ? 1 : 0,
      };
}
