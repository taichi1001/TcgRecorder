import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/repository/game_repository.dart';

class GameModel with ChangeNotifier {
  List<Game> allGameList;
  Game selectedGame;

  final gameRepo = GameRepo();

  GameModel() {
    _fetchAll();
  }

  void selectedGameChange(int index) {
    selectedGame = allGameList[index];
    notifyListeners();
  }

  Future _fetchAll() async {
    allGameList = await gameRepo.getAllTag();
    allGameList = [
      Game(gameId: 1, game: 'a'),
      Game(gameId: 2, game: 'b'),
      Game(gameId: 3, game: 'c')
    ];
    selectedGame = allGameList[0];
    notifyListeners();
  }

  Future add(Game game) async {
    gameRepo.insertTag(game);
    _fetchAll();
  }

  Future update(Game game) async {
    await gameRepo.updateTag(game);
    _fetchAll();
  }

  Future remove(Game game) async {
    await gameRepo.deleteTagById(game.gameId);
    _fetchAll();
  }
}
