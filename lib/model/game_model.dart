import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/entity/record.dart';
import 'package:tcg_recorder/repository/game_repository.dart';

class GameModel with ChangeNotifier {
  List<Game> allGameList = [];

  /// graphList用のgameList
  List<Game> graphListAllGameList = [];
  Game selectedGame;
  final GameRepo gameRepo;

  GameModel(this.gameRepo) {
    _fetchAll();
  }

  void changeSelectedGameUsingIndex(int index) {
    selectedGame = allGameList[index];
    notifyListeners();
  }

  void changeSelectedGameUsingString(String newValue) {
    if (newValue == '') {
      selectedGame = null;
    } else {
      selectedGame = Game(game: newValue);
    }
    notifyListeners();
  }

  void _changeItIfSelectedGameInDB() {
    if (allGameList
        .where((value) => value.game == selectedGame.game)
        .isNotEmpty) {
      selectedGame = allGameList
          .where((value) => value.game == selectedGame.game)
          .toList()[0];
    }
  }

  void findGameUsingRecord(Record record) {
    record.game = allGameList
        .where((value) => value.gameId == record.gameId)
        .toList()[0]
        .game;
  }

  Future addSelectedGame() async {
    _changeItIfSelectedGameInDB();
    if (selectedGame.gameId != 0) return;
    selectedGame.gameId = null;
    final selectedGameId = await gameRepo.insert(selectedGame);
    selectedGame.gameId = selectedGameId;
    await _getAllGameList();
    notifyListeners();
  }

  Future _fetchAll() async {
    await _getAllGameList();
    if (allGameList.length > 1) {
      selectedGame = allGameList[1];
    } else {
      selectedGame = null;
    }
    notifyListeners();
  }

  Future _getAllGameList() async {
    allGameList = await gameRepo.getAllTag();
    allGameList.insert(0, Game(game: ''));
    graphListAllGameList = await gameRepo.getAllTag();
  }

  Future add(Game game) async {
    await gameRepo.insert(game);
    await _fetchAll();
  }

  Future update(Game game) async {
    await gameRepo.update(game);
    await _fetchAll();
  }

  Future remove(Game game) async {
    await gameRepo.deleteById(game.gameId);
    await _fetchAll();
  }
}
