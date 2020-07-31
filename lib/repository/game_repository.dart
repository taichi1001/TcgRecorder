import 'package:tcg_recorder/dao/geme_dao.dart';
import 'package:tcg_recorder/entity/game.dart';

class GameRepo {
  final gameDao = GameDao();

  Future getAllTag() => gameDao.getAll();

  Future insertTag(Game game) => gameDao.create(game);

  Future updateTag(Game game) => gameDao.update(game);

  Future deleteTagById(int id) => gameDao.delete(id);

  //not use this
  Future deleteAllTag() => gameDao.deleteAll();
}
