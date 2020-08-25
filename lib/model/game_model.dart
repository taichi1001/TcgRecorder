import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/game_repository.dart';

class GameModel with ChangeNotifier {
  List<Game> allGameList = [];
  Game selectedGame;

  final gameRepo = GameRepo();

  GameModel() {
    _fetchAll();
  }

  void changeSelectedGameUsingIndex(int index) {
    selectedGame = allGameList[index];
    notifyListeners();
  }

  void changeSelectedGameUsingString(String newValue) {
    if (newValue == '') {
      selectedGame = null;
    } else if (allGameList.where((value) => value.game == newValue).isEmpty) {
      selectedGame = Game(game: newValue);
    } else {
      selectedGame =
          allGameList.where((value) => value.game == newValue).toList()[0];
    }
    notifyListeners();
  }

  void findGameUsingRecord(Record record) {
    record.game = allGameList
        .where((value) => value.gameId == record.gameId)
        .toList()[0]
        .game;
  }

  Future addSelectedGame() async{
    if(selectedGame.gameId !=0) return;
    selectedGame.gameId = null;
    final selectedGameId = await gameRepo.insert(selectedGame);
    selectedGame.gameId = selectedGameId;
    allGameList = await gameRepo.getAllTag();
    notifyListeners();
  }

  Future _fetchAll() async {
    allGameList = await gameRepo.getAllTag();
    if (allGameList.isNotEmpty) {
      selectedGame = allGameList[1];
    } else {
      selectedGame = null;
    }
    notifyListeners();
  }

  Future add(Game game) async {
    await gameRepo.insert(game);
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
