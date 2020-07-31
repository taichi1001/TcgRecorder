import 'package:flutter/material.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/repository/game_repository.dart';

class GameModel with ChangeNotifier {
  List<Game> allGameList;

  final gameRepo = GameRepo();

  GameModel() {
    _fetchAll();
  }

  Future _fetchAll() async {
    allGameList = await gameRepo.getAllTag();
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
