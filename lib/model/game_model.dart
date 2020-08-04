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

  void selectedGameChangeToIndex(int index) {
    selectedGame = allGameList[index];
    notifyListeners();
  }

  void selectedGameChangeToString(String newValue) {
    selectedGame.game = newValue;
    notifyListeners();
  }

  Future _fetchAll() async {
    allGameList = await gameRepo.getAllTag();
    selectedGame = allGameList[0];  
    notifyListeners();
  }

  Future add(Game game) async {
    gameRepo.insert(game);
    _fetchAll();
  }

  Future update(Game game) async {
    await gameRepo.update(game);
    _fetchAll();
  }

  Future remove(Game game) async {
    await gameRepo.deleteById(game.gameId);
    _fetchAll();
  }
}
