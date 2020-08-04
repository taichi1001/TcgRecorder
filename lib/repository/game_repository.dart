import 'package:tcg_recorder/dao/geme_dao.dart';
import 'package:tcg_recorder/entity/game.dart';

class GameRepo {
  final gameDao = GameDao();

  Future getAllTag() => gameDao.getAll();

  Future insert(Game game) => gameDao.create(game);

  Future update(Game game) => gameDao.update(game);

  Future deleteById(int id) => gameDao.delete(id);

  //not use this
  Future deleteAll() => gameDao.deleteAll();
}
