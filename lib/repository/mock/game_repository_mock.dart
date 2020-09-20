import 'package:tcg_recorder/dao/geme_dao.dart';
import 'package:tcg_recorder/entity/game.dart';
import 'package:tcg_recorder/repository/game_repository.dart';

class GameRepoMock implements GameRepo {
  final List<Game> _allGameList = [
    Game(gameId: 1, game: 'デュエマ'),
    Game(gameId: 2, game: 'MTG'),
  ];

  @override
  GameDao gameDao;

  @override
  Future getAll() async => _allGameList;

  @override
  Future insert(Game game) async {}

  @override
  Future update(Game game) async {}

  @override
  Future deleteById(int id) async {}

  //not use this
  @override
  Future deleteAll() async {}
}
